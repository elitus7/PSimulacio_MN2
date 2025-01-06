program angles
    integer :: i
    real (kind=8) :: angle,x,y,vx,vy,ax,ay,pos,cos,vel,dia

    open(unit=10,file='results_euler_1_d1dia.dat',status='old')
    open(unit=20,file='angposvel_1_dia.dat',status='replace')

    do i=1,2190
        read(10,*) dia,x,y,vx,vy,ax,ay
        vel=(vx**2+vy**2)**0.5 !Mòdul de la velocitat
        pos=(x**2+y**2)**0.5 !Mòdul de la posició
        cos=(x*vx+y*vy)/(vel*pos) !Cosinus
        angle=acos(cos) !Angle
        write(20,*) angle,pos,vel
    end do

    close(10)
    close(20)


end program angles