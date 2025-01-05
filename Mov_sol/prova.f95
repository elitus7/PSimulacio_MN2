program leer_datos
    implicit none
    integer, parameter :: n = 366  ! Número de filas
    real, dimension(n, 2) :: datos
    character(len=100) :: archivo
    real :: x, y
    integer :: i
  
    ! Nombre del archivo .dat
    archivo = 'terra_1_d1dia.dat'
  
    ! Abrimos el archivo para leer los datos
    open(unit=10, file=archivo, status='old')
  
    ! Leemos los datos del archivo
    do i = 1, n
      read(10, *) x, y
      datos(i, 1) = x
      datos(i, 2) = y
    end do
  
    close(10)
  
    ! Mostrar los datos leídos
    print *, 'Datos leídos del archivo:'
    do i = 1, n
      print *, 'x = ', datos(i, 1), ', y = ', datos(i, 2)
    end do
  
  end program leer_datos
  