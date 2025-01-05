program vels
    implicit none

    integer :: j, iostat
    real :: dades(6)

    open(unit=10, file='results_euler_1_d1dia.dat', status='old', action='read')
    open(unit=20, file='v_1_d1dia.dat', status='replace', action='write')

    do
        read(10, *, iostat=iostat) (dades(j), j = 1, 6) 
        if (iostat /= 0) exit

        write(20, *) dades(3)**2+dades(4)**2
    end do

    close(10)
    close(20)

end program vels

