program placa_solar
    implicit none
    Integer, parameter :: N_a = 365 !Passos temporals (tot l'any)
    Integer, parameter :: dies_mesos(12) = (/ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 /) ! Matriu que conté quants dies té cada mes
    Real, Allocatable :: Theta(:) !Angle d'incidencia solar vertical que depén de l'hora del dia
    Real :: Theta_max(N_a) !Angle maxim d'incidencia solar que depén de l'alçada a la qual aquest arriba discretitzarem per cada dia de l'any
    Real, Allocatable :: Phi(:) !Angle d'incidencia solar que depén de l'hora del dia (angle lateral), discretitzarem cada 30 min
    Real :: H_llum(N_a) !Interval de temps (en minuts) de llum solar
    Real :: Theta_0 = -15 + 10*0.162 ! Angle d'incidencia maxima de llum del dia 1 de gener
    Real :: H_llum_0 = 546 ! Minuts de llum del dia 1 de gener
    Real, Allocatable :: W_inc(:) ! Potencia per m^2 que incideix sobre la placa en cada discretització
    Real, Allocatable :: W_gen(:) ! Potència generada
    Real :: W_max = 1000
    Real :: sumes_mes(12)  ! Matriu per acumular les sumes de cada mes
    Logical :: exists
    Integer :: i, j, mes_actual, dia_actual
    Real :: factor_pluja_neu

    ! Inicialitzacio de les sumes
    sumes_mes = 0.0
    dia_actual = 1
    mes_actual = 1

    ! Càlcul dels angles màxims i minuts de llum
    Do i = 1, 172
        Theta_max(i) = Theta_0 + (i-1)*0.162
        H_llum(i) = H_llum_0 + (i-1)*2.115
    End Do
    Do i = 173, 356
        Theta_max(i) = 15 - (i-171)*0.162
        H_llum(i) = H_llum(i-1) - 2.115
    End Do
    Do i = 357, 365
        Theta_max(i) = -15 + (i-356)*0.162
        H_llum(i) = H_llum(i-1) + 2.115
    End Do
    ! Definim els diferents theta maxims i els minuts de llum que tenim al llarg de l'any 

    Allocate(phi(1))
    Allocate(theta(1))
    Allocate(W_inc(1))
    Allocate(W_gen(1))
    ! Definim temporalment les dimensions dels vectors per evitar problemes amb Fortran

    inquire(file="Energia_gen.dat", exist=exists)
    if (exists) then 
        call system("del /f Energia_gen.dat") !Elimina l'arxiu Energia_gen.dat creat previament (si existeix)
    end if

    inquire(file="Energia_mesos_J.dat", exist=exists)
    if (exists) then 
        call system("del /f Energia_mesos_J.dat") !Elimina l'arxiu Energia_mesos.dat creat previament (si existeix)
    end if

    inquire(file="Energia_mesos_kWh.dat", exist=exists)
    if (exists) then 
        call system("del /f Energia_mesos_kWh.dat") !Elimina l'arxiu Energia_mesos_kWh.dat creat previament (si existeix)
    end if


    
    Do i = 1, N_a

        Deallocate(Theta)
        Allocate(Theta(int(H_llum(i))))
        Deallocate(Phi)
        Allocate(phi(int(H_llum(i))))
        Deallocate(W_inc)
        Allocate(W_inc(int(H_llum(i))))
        Deallocate(W_gen)
        Allocate(W_gen(int(H_llum(i))))
        ! Donem dimensions a totes les variables segons el temps en què els arriba llum solar
        
        DO j = 1, int(H_llum(i)/2)
            Theta(j) = j*((Theta_max(i) + 42.5)/(H_llum(i)/2)) !Definim un angle theta que avança en cada pas el valor maxim entre la meitat de les hores de llum 
            If (Theta(j) > (Theta_max(i)) + 42.5) EXIT !L'angle avança fins arribar a Theta maxima
        END DO
        DO j = int(H_llum(i)/2) + 1, int(H_llum(i))
            Theta(j) = Theta(j-1) - ((Theta_max(i) + 42.5)/(H_llum(i)/2)) !Definim un angle theta anàleg a l'anterior pero que decreix durant la segona meitat del dia
            If (Theta(j) < 0.15) EXIT !L'angle avança fins arribar a Theta 0
        END DO
        Do j = 1, int(H_llum(i))
            Theta(j) = Theta(j) - 42.5 !canviem al sistema de referència de la placa solar, la qual esta inclinada 42.5 graus 
        END DO

        ! Càlculs d'angles Phi
        DO j = 1, int(H_llum(i))
            Phi(j) = -90 + j*(180/H_llum(i)) !Fem la discretització partint de la sortida de sol per l'esquerra i avança cada 30 minuts (desde el SR de la placa)
        END DO

        ! Càlcul de W_inc
        DO j = 1, int(H_llum(i))
            IF (Phi(j) >= -80 .AND. Phi(j) <= 80) THEN
                W_inc(j) = W_max*cos(theta(j)*(2*3.14159265)/360)*cos(phi(j)*(2*3.14159265)/360)
            ELSE
                W_inc(j) = 0.0 ! Eliminem les dades que estiguin per sota de -80 graus i per sobre de 80 graus (considerem les muntanyes del voltant)
            END IF
        END DO

        ! Factor pluja/neu
        select case(i)
            case (1:75) ! Gener a mitjans de Març
                factor_pluja_neu = 0.8 ! Reducció del 20% per neu 
            case (91:151) ! Abril-Maig
                factor_pluja_neu = 0.8 ! Reducció del 20% rendiment (Pluges intenses)
            case (152:181, 244:273) ! Juny, Setembre i Octubre
                factor_pluja_neu = 0.9 ! Reducció del 10% rendiment (Pluges moderades)
            case default
                factor_pluja_neu = 1.0 ! Tots els altres mesos no s'aplica cap reducció
        end select

        do j = 1, int(H_llum(i))
            W_inc(j) = W_inc(j)*factor_pluja_neu
        end do 

        open(unit=10, file="W_sol.dat", status="unknown", access="append")
        DO j = 1, int(H_llum(i))
            WRITE(10,*) W_inc(j)
        END DO
        WRITE(10,*) 
        Close(10)

        ! Càlcul de l'energia elèctrica generada
        do j= 1, int(H_llum(i))
            W_gen(j) = W_inc(j)*0.4*60
        end do

        ! Generem arxiu amb les dades d'energia elèctrica generada 
        open(unit=20, file="Energia_gen.dat", status="unknown", access="append")
        DO j = 1, int(H_llum(i))
            WRITE(20,*) W_gen(j)
        END DO
        WRITE(20,*) 
        Close(20)

        ! Acumulació de sumes mensuals
        DO j = 1, int(H_llum(i))
            sumes_mes(mes_actual) = sumes_mes(mes_actual) + W_gen(j)
        END DO

        ! Control del canvi de mes
        dia_actual = dia_actual + 1
        if (dia_actual > dies_mesos(mes_actual)) then
            mes_actual = mes_actual + 1
            dia_actual = 1
        end if
    End do

    ! Arxiu de l'energia generada per mesos en J
    open(unit=30, file="Energia_mesos_J.dat", status="replace", action="write")
    do i = 1, 12
        write(30, *) sumes_mes(i)
    end do
    close(30)

    ! Arxiu de l'energia generada per mesos en kWh
    open(unit=40, file="Energia_mesos_kWh.dat", status="replace", action="write")
    do i = 1, 12
        write(40, *) sumes_mes(i)/(3600000)
    end do
    close(40)

end program placa_solar
