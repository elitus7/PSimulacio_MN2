program euler_sist_solar !Codi per efectuar la simulació del sistema solar en el pla usant el mètode d'Euler. El programa està preparat per poder simular tots els cossos, però per simplicitat ens quedarem només amb el sistema Mercuri, Venus, Terra, Mart, Júpiter (i Sol, naturalment).
    implicit none(type, external)

    !Primer definim els factors de normalització, algunes constants i les variables que seran necessàries. Molts cops especifiquem (kind=8) per tal de tenir un grau de precissió major.
    real(kind=8), parameter :: d_0 = 1.495978707E11_8 !Unitat astronòmica (metres).
    real, parameter :: M_0 = 1.98847E30 !Massa del Sol (kilograms).
    real, parameter :: G = 6.67384E-11 !Constant de la gravitació universal.
    real(kind=8) :: t_0 = ((d_0**3)/(M_0*G))**(0.5) !Factor de normalització temporal (segons).
    real(kind=8) :: dt = 3600*24 !Discretització temporal, es correspon amb 1 dia. Més tard el normalitzem usant t_0.
    real(kind=8) :: t = 0 !Temps. El fixem inicialment a 0.
    real(kind=8) :: t_final = 365*24*3600 !Temps final a un any (en segons), més tard el normalitzarem.
    integer :: Nt !Passos temporals.
    integer :: i, j, k

    integer, parameter :: n = 2 !Dimensions. Treballem en el pla, per tant aquest valor és 2.
    integer, parameter :: p = 6 !Número de cossos al sistema solar modelitzat.
    real(kind=8), dimension(p, n) :: r, v !Vectors posicions i velocitat.
    real(kind=8), dimension(p) :: rx,ry,vx,vy,ax,ay
    real(kind=8), dimension(p) :: m  !Vector amb les masses normalitzades.
    real(kind=8) :: dx,dy,d,fx,fy

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
    
    !Posicions de tots els cossos segons Horizons Ephemersis en AU's (unitats normalitzades).
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
    
    dt = dt/t_0 !Normalitzem la discretització.
    t = t/t_0 !Normalitzem el temps inicial (si és 0, naturalment no cal).
    t_final = t_final/t_0 !Normalitzem el temps final.
    Nt = ceiling((t_final - t)/dt)



    !Ara implementem el mètode d'Euler.

    rx = r(:,1)
    ry = r(:,2)
    vx = v(:,1)
    vy = v(:,2)


    open(unit=10, file='results_euler.dat', status='replace')
    do i = 1, Nt
        !Calculem les acceleracions sobre cada cos. 
        ax = 0
        ay = 0
        do j = 1,p

            do k = 1,p 

                if (k /= j) then !No té sentit calcular l'acceleració que la Terra efectua sobre la Terra...
                    
                    dx = rx(j) - rx(k) !Distància en x entre dos cossos.
                    dy = ry(j) - ry(k) !Distància en y entre dos cossos.
                    d = (dx**2 + dy**2)**(0.5)

                    fx = - m(k) * dx / d**3 !Força (unitats normalitzades) en x.
                    fy = - m(k) * dy / d**3 !Força (unitats normalitzades) en y.

                    ax(j) = ax(j) + fx
                    ay(j) = ay(j) + fy

                   
                    
                end if
            
            end do

            
            !Un cop tenim l'acceleració sobre el planeta j, podem trobar les noves velocitats i, en conseqüència, les noves posicions.
            do k = 1, p
                vx(k) = vx(k) + ax(k) * dt
                vy(k) = vy(k) + ay(k) * dt
                rx(k) = rx(k) + vx(k) * dt
                ry(k) = ry(k) + vy(k) * dt
            end do

            r(j,1) = rx(j)
            r(j,2) = ry(j)
            v(j,1) = vx(j)
            v(j,2) = vy(j)
            
            
        end do

        do k = 1,p
            write(10,*) i, r(k,:)
        end do

        
    end do

    close(10)




end program euler_sist_solar