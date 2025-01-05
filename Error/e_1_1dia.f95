program error_1_1dia
    implicit none (type, external)
    real(kind=8), parameter :: d_0 = 1.495978707E11 !Unitat astronòmica (metres).
    real, parameter :: M_0 = 1.98847E30 !Massa del Sol (kilograms).
    real, parameter :: G = 6.67384E-11 !Constant de la gravitació universal.
    real(kind=8), parameter :: t_0 = ((d_0**3)/(M_0*G))**(0.5) !Factor de normalització temporal (segons).
    real(kind=8) :: dt = 3600*24 !Discretització temporal en segons.
    real(kind=8) :: t = 0 !Temps. El fixem inicialment a 0.
    real(kind=8) :: t_final = 365*24*3600 !Temps final (1 any en segons).
    integer :: Nt !Passos temporals.
    integer :: i, j, k, planet

    integer, parameter :: n = 2 !Dimensions, treballem en el pla (x, y).
    integer, parameter :: p = 6 !Número de cossos (6 astres al sistema modelitzat).
    real(kind=8), dimension(p, n) :: r, v, a !Vectors posicions, velocitat i acceleració.
    real(kind=8) :: vx, vy !Velocitats dels cossos.
    real(kind=8), dimension(p) :: m  !Massa de cada cos (normalitzada).
    real(kind=8) :: e_cin !Energia cinètica per a cada cos
    real(kind=8), dimension(p) :: energies

    !Masses dels planetes en kg's.
    real(kind=8), parameter :: Ma_mer = 3.30E23
    real(kind=8), parameter :: Ma_ven = 4.87E24
    real(kind=8), parameter :: Ma_ter = 5.97E24
    real(kind=8), parameter :: Ma_mar = 6.42E23
    real(kind=8), parameter :: Ma_jup = 1.90E27

    !Masses normalitzades dels planetes.
    m(1) = M_0 / M_0
    m(2) = Ma_mer / M_0
    m(3) = Ma_ven / M_0
    m(4) = Ma_ter / M_0
    m(5) = Ma_mar / M_0
    m(6) = Ma_jup / M_0

    open(unit=10, file='v_1_d1dia.dat', status='old')
    open(unit=20, file='1_d1dia_k.dat', status='replace')

    !Càlcul energia cinètica K
    do i = 1, Nt  !Cicle temporal, passes per cada instant de temps
        ! Cada 6 línies tenim un instant temporal
        do planet = 1, 6
            read(10, *) vx, vy

            ! Calcula l'energia cinètica per al cos corresponent.
            e_cin = 0.5 * m(planet) * (vx**2 + vy**2)

            ! Emmagatzema l'energia per al cos 'k' a l'instant de temps actual
            energies(planet) = e_cin

            ! Escriu l'energia cinètica per a cada cos a un fitxer separat, per exemple.
            open(unit=20 + planet, file='1_d1dia_k.dat', status='replace', action='write')
            write(20,*) e_cin
            close(20)
        end do
    end do

    close(10)
end program error_1_1dia
