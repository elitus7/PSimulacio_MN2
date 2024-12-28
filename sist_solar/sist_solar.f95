program sist_solar !Codi per efectuar la simulació del sistema solar en el pla usant el mètode RK4. El programa està preparat per poder simular tots els cossos, però per simplicitat ens quedarem només amb el sistema Mercuri, Venus, Terra, Mart, Júpiter (i Sol, naturalment).
    implicit none(type, external)

    !Primer definim els factors de normalització, algunes constants i les variables que seran necessàries. Molts cops especifiquem (kind=8) per tal de tenir un grau de precissió major.
    real(kind=8), parameter :: d_0 = 1.495978707E11_8 !Unitat astronòmica (metres).
    real, parameter :: M_0 = 1.98847E30 !Massa del Sol (kilograms).
    real, parameter :: G = 6.67384E-11 !Constant de la gravitació universal.
    real(kind=8) :: t_0 = ((d_0**3)/(M_0*G))**(0.5) !Factor de normalització temporal (segons).
    real(kind=8) :: dt = 1*24*3600 !Discretització temporal, es correspon amb 1 dia. Més tard el normalitzem usant t_0.
    real(kind=8) :: t = 0 !Temps. El fixem inicialment a 0.
    real(kind=8) :: t_final = 365*24*3600 !Temps final a un any (en segons), més tard el normalitzarem.
    integer :: Nt !Passos temporals.
    integer :: i, j, k

    integer, parameter :: n = 2 !Dimensions. Treballem en el pla, per tant aquest valor és 2.
    integer, parameter :: p = 6 !Número de cossos al sistema solar modelitzat.
    integer :: q = n*p !Número d'equacions.
    real(kind=8), dimension(p, n) :: r, v !Vectors posicions i velocitat.
    real(kind=8), dimension(p, 2*n) :: estat, estat_temp, d_estat,d_estat_temp !Vectors d'estat que agrupa posicions i velocitats.
    real(kind=8), dimension(p) :: rx,ry,vx,vy,ax,ay
    real(kind=8), dimension(p) :: m  !Vector amb les masses normalitzades.
    real(kind=8), dimension(p, 2*n) :: k1, k2, k3, k4 !Útils per a la implementació del RK4.
    real(kind=8) :: dx,dy,r_ij,r_ij3,fx,fy
    

    !Masses dels planetes en kg's.
    real(kind=8), parameter :: Ma_mer = 3.30E23
    real(kind=8), parameter :: Ma_ven = 4.87E24
    real(kind=8), parameter :: Ma_ter = 5.97E24
    real(kind=8), parameter :: Ma_mar = 6.42E23
    real(kind=8), parameter :: Ma_jup = 1.90E27
    !real(kind=8), parameter :: Ma_sat = 5.68E26
    !real(kind=8), parameter :: Ma_ura = 8.68E25
    !real(kind=8), parameter :: Ma_nep = 1.02E26

    !Masses normalitzaces dels planetes.
    real(kind=8) :: m_mer = Ma_mer/M_0
    real(kind=8) :: m_ven = Ma_ven/M_0
    real(kind=8) :: m_ter = Ma_ter/M_0
    real(kind=8) :: m_mar = Ma_mar/M_0
    real(kind=8) :: m_jup = Ma_jup/M_0
    !real(kind=8) :: m_sat = Ma_sat/M_0
    !real(kind=8) :: m_nep = Ma_nep/M_0
    !real(kind=8) :: m_ura = Ma_ura/M_0
    
    !Posicions de tots els cossos segons Horizons Ephemersis en AU's.
    real(kind=8), dimension(2) :: r0_s = (/ 0.0, 0.0 /)
    real(kind=8), dimension(2) :: r0_mer = (/ -3.873030085256687E-01, -1.617241946342014E-01 /)
    real(kind=8), dimension(2) :: r0_ven = (/ 4.534187654737982E-01, 5.622160792960551E-01 /)
    real(kind=8), dimension(2) :: r0_ter = (/ -1.786834409731047E-01, 9.669827953774551E-01 /)
    real(kind=8), dimension(2) :: r0_mar = (/ -5.216858665681380E-01, 1.525234576802456E+00 /)
    real(kind=8), dimension(2) :: r0_jup = (/ 1.056033545576702E+00, 4.971452162023883E+00 /)
    !real(kind=8), dimension(2) :: r0_sat = (/ 9.461067271500818E+00, -1.764614720843175E+00 /)
    !real(kind=8), dimension(2) :: r0_ura = (/ 1.110363513617210E+01, 1.609448694134911E+01 /)
    !real(kind=8), dimension(2) :: r0_nep = (/ 2.987992735576156E+01, -6.341879950443392E-01 /)

    !Velocitats de tots els cossos segons Horizons Ephemersis en AU's/dia.
    real(kind=8), dimension(2) :: v0_s = (/ 0.0, 0.0 /)
    real(kind=8), dimension(2) :: v0_mer = (/ 5.024430196457658E-03, -2.474345331076241E-02 /)
    real(kind=8), dimension(2) :: v0_ven = (/ -1.580627428004959E-02, 1.261006264179427E-02 /)
    real(kind=8), dimension(2) :: v0_ter = (/ -1.720473858166942E-02, -3.193533189307208E-03 /)
    real(kind=8), dimension(2) :: v0_mar = (/ -1.271183490340182E-02, -3.338839586392289E-03 /)
    real(kind=8), dimension(2) :: v0_jup = (/ -7.476272400979211E-03, 1.924466075080766E-03 /)
    !real(kind=8), dimension(2) :: v0_sat = (/ 7.093807804551229E-04, 5.475097536527790E-03 /)
    !real(kind=8), dimension(2) :: v0_ura = (/ -3.273722830755306E-03, 2.053528375126505E-03 /)
    !real(kind=8), dimension(2) :: v0_nep = (/ 3.941595250081164E-05, 3.160389775728832E-03 /)

    !Inicialitzem tots els vectors.
    m(1) = M_0/M_0
    m(2) = m_mer
    m(3) = m_ven
    m(4) = m_ter
    m(5) = m_mar
    m(6) = m_jup
    !m(7) = m_sat
    !m(8) = m_ura
    !m(9) = m_nep

    r(1,:) = r0_s
    r(2,:) = r0_mer
    r(3,:) = r0_ven
    r(4,:) = r0_ter
    r(5,:) = r0_mar
    r(6,:) = r0_jup
    !r(7,:) = r0_sat
    !r(8,:) = r0_ura
    !r(9,:) = r0_nep

    v(1,:) = v0_s
    v(2,:) = v0_mer
    v(3,:) = v0_ven
    v(4,:) = v0_ter
    v(5,:) = v0_mar
    v(6,:) = v0_jup
    !v(7,:) = v0_sat
    !v(8,:) = v0_ura
    !v(9,:) = v0_nep

    open(unit=10, file="p0_ssolar.dat",status="replace")
        do i = 1, 6
            write(10,*) (r(i,:))
        end do
    close(10)
    
    dt = dt/t_0 !Normalitzem la discretització.
    t = t/t_0 !Normalitzem el temps inicial (si és 0, naturalment no cal).
    t_final = t_final/t_0 !Normalitzem el temps final.
    Nt = ceiling((t_final - t)/dt)


    !Per treballar més cómodament ara definirem un vecot d'estat que agrupi, per cada cos, (posicions, velocitats). 
    call vector_estat(r,v,estat,p,n)
    open(unit=10, file="estat0_ssolar.dat",status="replace") !Arxiu amb el vector estat inicial. Cada fila és un cos i es llegeix com (x,y,vx,vy).
        do i = 1, 6
            write(10,*) (estat(i,:))
        end do
    close(10)

    !De forma similar, definim la corresponent derivada del vector d'estat, que agrupa per cada cos (velocitats, acceleracions)
    call deriv_estat(r,v,estat,d_estat,p,n,rx,ry,vx,vy,ax,ay)
    open(unit=10, file="d_estat0_ssolar.dat",status="replace") !Arxiu amb la derivada vector estat inicial. Cada fila és un cos i es llegeix com (vx,vy,ax,ay).
        do i = 1, 6
            write(10,*) (d_estat(i,:))
        end do
    close(10)

    !Implementem RK4.
    open(unit=20, file='results.dat', status='replace')
    do k = 1, Nt
        
        !Calculem les k's que ens permeten actualitzar el vector d'estat
        k1 = dt * d_estat
        k2 = dt * d_estat + 0.5 * k1
        k3 = dt * d_estat + 0.5 * k2
        k4 = dt * d_estat + k3
        
        d_estat = d_estat + (1.0 / 6.0) * (k1 + 2.0 * k2 + 2.0 * k3 + k4)

        !Amb les velocitats (primeres 2 columnes del d_estat), podem trobar les noves posicions per a cada cos.
        do j = 1, p 
            estat(j,3) = d_estat(j,1) !Actualitzem vx.
            estat(j,4) = d_estat(j,2) !Actualitzem vy.
            estat(j,1) = estat(j,1) + dt * d_estat(j,1) !Actualitzem x.
            estat(j,2) = estat(j,2) + dt * d_estat(j,2) !Actualitzem y.

            write(20,*) k, estat(j,:)
        end do
        

    end do




    close(10)
    contains
        
        subroutine vector_estat(r,v,estat,p,n) !Subrutina que calcula el vector d'estat (x,y,vx,vy).
            implicit none(type, external) 
            integer, intent(in) :: p
            integer, intent(in) :: n
            real(kind=8), dimension(p, n), intent(in) :: r,v
            real(kind=8), dimension(p, 2*n), intent(out) :: estat
            integer :: i
        
            do i = 1, p
                estat(i,1) = r(i,1)
                estat(i,2) = r(i,2)
                estat(i,3) = v(i,1)
                estat(i,4) = v(i,2)
            end do
        end subroutine
         
        subroutine deriv_estat(r,v,estat,d_estat,p,n,rx,ry,vx,vy,ax,ay) !Subrutina que calcula la derivada del vector d'estat per cada instant de tempps (vx,vy,ax,ay).
            integer, intent(in) :: p
            integer, intent(in) :: n
            real(kind=8), dimension(p, n), intent(in) :: r,v
            real(kind=8), dimension(p, 2*n), intent(in) :: estat !(x,y,vx,vy)
            real(kind=8), dimension(p, 2*n), intent(out) :: d_estat !(vx,vy,ax,ay)
            real(kind=8), dimension(p), intent(out) :: rx,ry,vx,vy,ax,ay
            real(kind=8) :: dx,dy,r_ij,r_ij3,fx,fy

            do i = 1, p
                rx(i) = r(i,1)
                ry(i) = r(i,2)
                vx(i) = v(i,1)
                vy(i) = v(i,2)
            end do

            do i = 1, p
                d_estat(i,1) = vx(i)
                d_estat(i,2) = vy(i)
                d_estat(i,3) = 0.0 !Inicialitzem les acceleracions a 0.
                d_estat(i,4) = 0.0
            end do

            !Calculem les acceleracions a les que cada cos està sotmés.
            do i = 1, p
                ax(i) = 0.0
                ay(i) = 0.0

                do j = 1, p 
                    if (i /=j) then !Naturalment, no té sentit calcular l'acceleració que provoca el cos i sobre ell mateix.
                        
                        dx = rx(i) - rx(j) !Distància en x entre dos cossos.
                        dy = ry(i) - ry(j) !Distància en y entre dos cossos.
                        r_ij = sqrt(dx**2 + dy**2) !Distància total entre dos cossos.
                        r_ij3 = r_ij**3

                        fx = - G * m(j) * dx / r_ij3 !Força ponderada en x.
                        fy = - G * m(j) * dy / r_ij3 !Força ponderada en y.

                        ax(i) = ax(i) + fx
                        ay(i) = ax(i) + fy
                    end if
                end do

            end do

            do i = 1, p
                d_estat(i,1) = vx(i)
                d_estat(i,2) = vy(i)
                d_estat(i,3) = ax(i)
                d_estat(i,4) = ay(i)
            end do
        end subroutine 


    
end program sist_solar