program placa_solar
    implicit none
    Integer, parameter :: N_a = 366 !Passos temporals (tot l'any) 
    Real, Allocatable :: Theta(:) !Angle d'incidencia solar vertical que depén de l'hora del dia
    Real :: Theta_max (N_a) !Angle maxim d'incidencia solar que depén de l'alçada a la qual aquest arriba discretitzarem per cada dia de l'any
    Real, Allocatable :: Phi(:) !Angle d'incidencia solar que depén de l'hora del dia (angle lateral), discretitzarem cada 30 min
    Real :: H_llum(N_a) !Interval de temps (en minuts) de llum solar
    Real :: Theta_0 = -15 + 10*0.162! Angle d'incidencia maxima de llum del dia 1 de gener
    Real :: H_llum_0 = 546 ! Minuts de llum del dia 1 de gener
    Real, Allocatable :: W_inc(:) ! Potencia per m^2 que incideix sobre la placa en cada discretització
    Real :: W_max = 1000
    Logical :: exists
    Integer :: i, j

    Do i = 1,172
        Theta_max(i) = Theta_0 + (i-1)*0.162
        H_llum(i) = H_llum_0 + (i-1)*2.115
    End Do
    Do i = 173, 356
        Theta_max(i) = 15 - (i-171)*0.162
        H_llum(i) = H_llum(i-1) - 2.115
    End Do
    Do i = 357, 366
        Theta_max(i) = -15 + (i-356)*0.162
        H_llum(i) = H_llum(i-1) + 2.115
    End Do
    ! Definim els diferents theta maxims i els minuts de llum que tenim al llarg de l'any 

    Allocate(phi(1))
    Allocate(theta(1))
    Allocate(W_inc(1))
    ! Definim temporalment les dimensions dels vectors per evitar problemes amb Fortran
   
    inquire(file="mov_sol.dat", exist=exists)
    if (exists) then 
        call system("del /f W_sol.dat") !Elimina l'arxiu W_sol.dat creat previament (si existeix)
    end if

    Do i = 1, N_a

        Deallocate(Theta)
        Allocate(Theta(int(H_llum(i))))
        Deallocate(Phi)
        Allocate(phi(int(H_llum(i))))
        Deallocate(W_inc)
        Allocate(W_inc(int(H_llum(i))))
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
            Theta(j) = Theta(j) - 42.5
        END DO !canviem al sistema de referència de la placa solar, la qual esta inclinada 42.5 graus 

        DO j = 1, int(H_llum(i))
            Phi(j) = -80 + j*(160/H_llum(i)) !Fem la discretització partint de la sortida de sol per l'esquerra i avança cada 30 minuts (desde el SR de la placa)
        END DO

        DO j = 1, int(H_llum(i))
            W_inc(j) = W_max * cos(theta(j)*(2*3.14159265)/360) * cos(phi(j)*(2*3.14159265)/360)
        END DO
        ! Calculem la quantitat d'irradació solar que rebem en cada discretització de temps

        open(unit=10,file="W_sol.dat",status="unknown", access = "append")
        DO j = 1, int(H_llum(i))
            WRITE(10,*) W_inc(j)
        END DO
        WRITE(10,*) !
        Close(10)
        ! FALTA PONER LA ELECTRICIDAD PRODUCIDA EN FUNCION DE LA LUZ INCIDENTE (MIRAR GUION)
        ! Anem recopilant les dades en un fitxer .dat

    End do

end program placa_solar