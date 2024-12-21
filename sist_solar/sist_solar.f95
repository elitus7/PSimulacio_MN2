program sist_solar
    !Primer definim els factors de normalització i algunes constants que seran necessàries.
    real(kind=8), parameter :: d_0 = 1.495978707E11_8 !Unitat astronòmica (metres).
    real, parameter :: M_0 = 1.98847E30 !Massa del Sol (kilograms).
    real, parameter :: G = 6.67384E-11 !Constant de la gravitació universal.
    real :: t_0 = ((d_0**3)/(M_0*G))**(0.5) !Factor de normalització temporal (segons).
    
    
end program sist_solar