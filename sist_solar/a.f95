program rk4_system
    implicit none
    integer, parameter :: n = 2 ! Número de ecuaciones en el sistema
    real :: x, h, x_end
    real, dimension(n) :: y
    integer :: n_steps, i

    ! Valores iniciales
    x = 0.0           ! Punto inicial
    y(1) = 1.0        ! Valor inicial de y1
    y(2) = 0.0        ! Valor inicial de y2
    h = 0.1           ! Paso de integración
    x_end = 2.0       ! Límite superior de x
    n_steps = int((x_end - x) / h) ! Número de pasos

    ! Impresión de encabezado
    print *, "x", "y1", "y2"
    print *, x, y(1), y(2)

    ! Iteración usando RK4
    do i = 1, n_steps
        call rk4_step(x, y, h, n)
        print *, x, y(1), y(2)
    end do
end program

! Subrutina para realizar un paso de RK4
subroutine rk4_step(x, y, h, n)
    implicit none
    integer, intent(in) :: n
    real, intent(inout) :: x
    real, intent(inout), dimension(n) :: y
    real, intent(in) :: h
    real, dimension(n) :: k1, k2, k3, k4, y_temp
    integer :: i

    ! Calcula k1
    call f(x, y, k1, n)

    ! Calcula k2
    y_temp = y + 0.5 * h * k1
    call f(x + 0.5 * h, y_temp, k2, n)

    ! Calcula k3
    y_temp = y + 0.5 * h * k2
    call f(x + 0.5 * h, y_temp, k3, n)

    ! Calcula k4
    y_temp = y + h * k3
    call f(x + h, y_temp, k4, n)

    ! Actualiza y y x
    y = y + (h / 6.0) * (k1 + 2.0 * k2 + 2.0 * k3 + k4)
    x = x + h
end subroutine

! Subrutina para evaluar el sistema de ecuaciones
subroutine f(x, y, dydx, n)
    implicit none
    integer, intent(in) :: n
    real, intent(in) :: x
    real, intent(in), dimension(n) :: y
    real, intent(out), dimension(n) :: dydx

    ! Definición del sistema de ecuaciones
    dydx(1) = y(2)                 ! dy1/dx = y2
    dydx(2) = -y(1) - y(2)         ! dy2/dx = -y1 - y2
end subroutine
