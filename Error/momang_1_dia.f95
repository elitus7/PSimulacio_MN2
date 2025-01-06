program m_ang
    integer :: i,j
    real (kind=8) :: pos,vel
    real(kind=8) :: momang_sol,momang_mer,momang_ven,momang_ter,momang_mar,momang_jup,m_ang_total
    real (kind=8) :: sol,mer,ven,ter,mar,jup

    !Masses dels planetes en kg's.
    real(kind=8), parameter :: Ma_mer = 3.30E23
    real(kind=8), parameter :: Ma_ven = 4.87E24
    real(kind=8), parameter :: Ma_ter = 5.97E24
    real(kind=8), parameter :: Ma_mar = 6.42E23
    real(kind=8), parameter :: Ma_jup = 1.90E27
    !real(kind=8), parameter :: Ma_sat = 5.68E26
    !real(kind=8), parameter :: Ma_ura = 8.68E25
    !real(kind=8), parameter :: Ma_nep = 1.02E26

    real, parameter :: M_0 = 1.98847E30 !Massa del Sol (kilograms).

    !Masses normalitzades dels planetes.
    real(kind=8) :: m_mer = Ma_mer/M_0
    real(kind=8) :: m_ven = Ma_ven/M_0
    real(kind=8) :: m_ter = Ma_ter/M_0
    real(kind=8) :: m_mar = Ma_mar/M_0
    real(kind=8) :: m_jup = Ma_jup/M_0
    !real(kind=8) :: m_sat = Ma_sat/M_0
    !real(kind=8) :: m_nep = Ma_nep/M_0
    !real(kind=8) :: m_ura = Ma_ura/M_0

    open(unit=20,file='angposvel_1_dia.dat',status='old')
    open(unit=30,file='m_ang_sol_dia.dat',status='replace')
    open(unit=40,file='m_ang_mer_dia.dat',status='replace')
    open(unit=50,file='m_ang_ven_dia.dat',status='replace')
    open(unit=60,file='m_ang_ter_dia.dat',status='replace')
    open(unit=70,file='m_ang_mar_dia.dat',status='replace')
    open(unit=80,file='m_ang_jup_dia.dat',status='replace')


    do i=1,2185,6 !Pels valors del Sol (files 1,7,13...)
        read(20,*) ang,pos,vel
        momang_sol=pos*vel*sin(ang) ! L = r x p = rmv·sin
        write(30,*) momang_sol
    end do

    do i=2,2186,6 !Pels valors de Mercuri (files 2,8,14...)
        read(20,*) ang,pos,vel
        momang_mer=m_mer*pos*vel*sin(ang) ! L = r x p = rmv·sin
        write(40,*) momang_mer
    end do    

    do i=3,2187,6 !Pels valors de Venus (files 3,9,15...)
        read(20,*) ang,pos,vel
        momang_ven=m_ven*pos*vel*sin(ang) ! L = r x p = rmv·sin
        write(50,*) momang_ven
    end do  

    do i=4,2188,6 !Pels valors de la Terra (4,10,16...)
        read(20,*) ang,pos,vel
        momang_ter=m_ter*pos*vel*sin(ang) ! L = r x p = rmv·sin
        write(60,*) momang_ter
    end do  

    do i=5,2189,6 !Pels valors de Mart (files 5,11,17...)
        read(20,*) ang,pos,vel
        momang_mar=m_mar*pos*vel*sin(ang) ! L = r x p = rmv·sin
        write(70,*) momang_mar
    end do  

    do i=6,2190,6 !Pels valors de Júpiter (files 6,12,18...)
        read(20,*) ang,pos,vel
        momang_jup=m_jup*pos*vel*sin(ang) ! L = r x p = rmv·sin
        write(80,*) momang_jup
    end do  

    close(20)
    close(30)
    close(40)
    close(50)
    close(60)
    close(70)
    close(80)

    open(unit=30,file='m_ang_sol_dia.dat',status='old')
    open(unit=40,file='m_ang_mer_dia.dat',status='old')
    open(unit=50,file='m_ang_ven_dia.dat',status='old')
    open(unit=60,file='m_ang_ter_dia.dat',status='old')
    open(unit=70,file='m_ang_mar_dia.dat',status='old')
    open(unit=80,file='m_ang_jup_dia.dat',status='old')
    open(unit=90,file='m_ang_total_1_dia.dat',status='replace')

    do j=1,365
        read(30,*) sol
        read(40,*) mer
        read(50,*) ven
        read(60,*) ter
        read(70,*) mar
        read(80,*) jup
        m_ang_total=sol+mer+ven+ter+mar+jup
        write(90,*) m_ang_total
    end do

    close(30)
    close(40)
    close(50)
    close(60)
    close(70)
    close(80)
    close(90)

end program m_ang