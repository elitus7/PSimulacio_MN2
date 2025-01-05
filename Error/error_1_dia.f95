program e_1_1

    implicit none (type, external)
    integer:: fila
    real(kind=8), dimension(6) :: e0, e, error


    open(unit=10, file='matriusEs_1_dia.dat', status='old') !Matriu de les energies per cada temps
    open(unit=20, file='error_1_dia.dat', status='replace') !Fitxer on escriurem els resultats

    read(10,*) e0 !Energia al primer punt. Serveix de referència.

    do fila=2,365
        read(10,*) e !Energies per cada fila
        error = (e-e0)/e0 !Error
        write(20,*) fila,error
    end do

    close(10)
    close(20)

end program e_1_1