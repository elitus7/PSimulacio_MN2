program mov_sol
    implicit none
    Integer, parameter :: N_a = 366 !Passos temporals (tot l'any) 
    Real, Allocatable :: Theta(:) !Angle d'incidencia solar vertical que depén de l'hora del dia
    Real :: Theta_max (N_a) !Angle maxim d'incidencia solar que depén de l'alçada a la qual aquest arriba discretitzarem per cada dia de l'any
    Real, Allocatable :: Phi(:) !Angle d'incidencia solar que depén de l'hora del dia (angle lateral), discretitzarem cada 30 min
    Real :: H_llum(N_a) !Interval de temps (en minuts) de llum solar
    Real, Allocatable :: pos_sol(:,:) !Posició del sol vist desde la placa solar
    Real :: Theta_0 = -15 + 10*0.162! Angle d'incidencia maxima de llum del dia 1 de gener
    Real :: H_llum_0 = 546 ! Minuts de llum del dia 1 de gener
    logical :: exists

    real, dimension(N_a, 2) :: dades_terra, dades_sol, resultat
    real, dimension(N_a) :: modul_resultat  ! Matriu pels mòduls
    character(len=100) :: fitxer_terra, fitxer_sol
    real :: x, y
    integer :: i, j, k
  
    fitxer_terra = 'terra_1_d1dia.dat'
    fitxer_sol = 'sol_1_d1dia.dat'  
    
    ! Obrim arxiu Terra
    open(unit=10, file=fitxer_terra, status='old')
    
    ! Llegim les dades del primer fitxer (dades de la terra)
    do i = 1, N_a
      read(10, *) x, y
      dades_terra(i, 1) = x
      dades_terra(i, 2) = y
    end do
    close(10)
  
    ! Obrim arxiu Sol
    open(unit=20, file=fitxer_sol, status='old')
  
    ! Llegim les dades del segon fitxer (dades del sol)
    do i = 1, N_a
      read(20, *) x, y
      dades_sol(i, 1) = x
      dades_sol(i, 2) = y
    end do
    close(20)
  
    ! Restem les matrius de les posicons de la Terra amb les del Sol 
    do i = 1, N_a
      resultat(i, 1) = dades_terra(i, 1) - dades_sol(i, 1)  
      resultat(i, 2) = dades_terra(i, 2) - dades_sol(i, 2)  
    end do
  
    ! Calcular el mòdul per cada fila de la matriu resultat
    do i = 1, N_a
      modul_resultat(i) = sqrt(resultat(i, 1)**2 + resultat(i, 2)**2)
    end do

    Do i = 1,172
        Theta_max(i) = Theta_0 + i*0.162
        H_llum(i) = H_llum_0 + i*2.115
    End Do
    Do i = 172, 356
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
    Allocate(pos_sol(2,1))
    ! Definim temporalment les dimensions dels vectors per evitar problemes amb Fortran
    
    inquire(file="mov_sol.dat", exist=exists)
    if (exists) then 
        call system("del /f mov_sol.dat") !Elimina l'arxiu mov_sol.dat creat previament (si existeix)
    end if

    Do i = 1, N_a

        Deallocate(Pos_sol)
        Allocate(Pos_sol((int(H_llum(i))),2))
        Deallocate(Theta)
        Allocate(Theta(int(H_llum(i))))
        Deallocate(Phi)
        Allocate(phi(int(H_llum(i))))
        ! Donem dimensions a totes les variables segons el temps en què els arriba llum solar

        DO j = 1, int(H_llum(i)/2)
            Theta(j) = j*((Theta_max(i) + 42.5)/(H_llum(i)/2)) !Definim un angle theta que avança en cada pas el valor maxim entre la meitat de les hores de llum 
            If (Theta(j) > (Theta_max(i) + 42.5)) EXIT !L'angle avança fins arribar a Theta maxima
        END DO
        DO j = int(H_llum(i)/2) + 1, int(H_llum(i))
            Theta(j) = Theta(j-1) - ((Theta_max(i) + 42.5)/(H_llum(i)/2)) !Definim un angle theta anàleg a l'anterior pero que decreix durant la segona meitat del dia
            If (Theta(j) < 0.15) EXIT !L'angle avança fins arribar a Theta 0
        END DO

        DO j = 1, int(H_llum(i))
            Phi(j) = 0 + j*(180/H_llum(i)) !Fem la discretització partint de la sortida de sol per l'esquerra i avança cada 30 minuts
        END DO

        
        DO j = 1, int(H_llum(i))
            Pos_sol(j,1) = modul_resultat(i)*cos(phi(j)*(2*3.14159265)/360)
            Pos_sol(j,2) = modul_resultat(i)*sin(theta(j)*(2*3.14159265)/360)*sin(phi(j)*(2*3.14159265)/360)
        END DO
        ! Apliquem els valors dels angles en coordenades esfèriques per trobar les coordenades x,y cartesianes (z,y en esfèriques) del sol agafant el terra com SR
        
        open(unit=10,file="mov_sol.dat",status="unknown", access = "append")
        DO j = 1, int(H_llum(i))
            WRITE(10,*) Pos_sol(j,:)
        END DO
        WRITE(10,*) !
        Close(10)
        ! Anem recopilant la posició de tots els dies en una mateix arxiu .dat
    END Do
 
    End program mov_sol