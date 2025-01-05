program mov_sol
    implicit none
    Integer, parameter :: N_a = 366 !Passos temporals (tot l'any)
    Integer, parameter :: N_d = 48 !Passos temporals (tot el dia) 
    Real :: Theta_max (N_a) !Angle maxim d'incidencia solar que depén de l'alçada a la qual aquest arriba discretitzarem per cada dia de l'any
    Real, Allocatable :: Phi(:) !Angle d'incidencia solar que depén de l'hora del dia (angle lateral), discretitzarem cada 30 min
    Real :: H_llum(N_a) !Interval d'hores (en minuts) de llum solar
    Real :: dist(N_a) !Distancia terra - sol en cada dia de l'any
    Real :: pos_sol(2) !Posició del sol vist desde la placa solar
    Real :: Theta_0 = -15 + 10*(30/183) ! Angle d'incidencia de llum del dia 1 de gener
    Real :: H_llum_0 = 546 ! Minuts de llum del dia 1 de gener

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

    Do i = 1,81
        Theta_max(i) = Theta_0 + i*(30/183)
        H_llum(i) = H_llum_0 + i*2.115
    End Do
    Do i = 82, 356
        Theta_max(i) = 15 - i*(30/183)
        H_llum(i) = H_llum(i-1) - 2.115
    End Do
    Do i = 357, 366
        Theta_max(i) = -15 + i*(30/183)
        H_llum(i) = H_llum(i-1) + 2.115
    End Do
    ! Definim els diferents theta maxims i les hores de llum que tenim al llarg de l'any 
    Allocate(phi(1))
    Do i = 1, N_a
        Do j = 1, range(phi)
            Phi(j) = 0
        END DO
        Deallocate(Phi)
        Allocate(phi(int(H_llum(i))))
        DO j = 1, int(H_llum(i))
            Phi(j) = - 90 + j*(180/H_llum(i)) !Fem la discretització partint de la sortida de sol per l'esquerra i avança cada 30 minuts
            If (Phi(j) > 90) EXIT !L'angle va avançant fins arribar a phi = 90 graus
        END DO
    END Do

    Write(*,*) Phi
    End program mov_sol