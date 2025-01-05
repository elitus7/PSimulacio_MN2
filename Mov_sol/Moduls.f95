program Moviment
    implicit none
    integer, parameter :: n = 366  ! Nombre de files
    real, dimension(n, 2) :: dades_terra, dades_sol, resultat
    real, dimension(n) :: modul_resultat  ! Matriu pels mòduls
    character(len=100) :: fitxer_terra, fitxer_sol
    real :: x, y
    integer :: i
  
    fitxer_terra = 'terra_1_d1dia.dat'
    fitxer_sol = 'sol_1_d1dia.dat'  
    
    ! Obrim arxiu Terra
    open(unit=10, file=fitxer_terra, status='old')
    
    ! Llegim les dades del primer fitxer (dades de la terra)
    do i = 1, n
      read(10, *) x, y
      dades_terra(i, 1) = x
      dades_terra(i, 2) = y
    end do
    close(10)
  
    ! Obrim arxiu Sol
    open(unit=20, file=fitxer_sol, status='old')
  
    ! Llegim les dades del segon fitxer (dades del sol)
    do i = 1, n
      read(20, *) x, y
      dades_sol(i, 1) = x
      dades_sol(i, 2) = y
    end do
    close(20)
  
    ! Restem les matrius de les posicons de la Terra amb les del Sol 
    do i = 1, n
      resultat(i, 1) = dades_terra(i, 1) - dades_sol(i, 1)  
      resultat(i, 2) = dades_terra(i, 2) - dades_sol(i, 2)  
    end do
  
    ! Calcular el mòdul per cada fila de la matriu resultat
    do i = 1, n
      modul_resultat(i) = sqrt(resultat(i, 1)**2 + resultat(i, 2)**2)
    end do
  
    ! Mòduls distancia Sol - Terra
    do i = 1, n
      print *,  modul_resultat(i)
    end do
  
end program Moviment 