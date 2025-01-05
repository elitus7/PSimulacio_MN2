program mov_sol
    Integer :: N_a !Passos temporals (tot l'any)
    Integer :: N_d !Passos temporals (tot el dia)
    Real, dimension(N_a) :: Theta !Angle d'incidencia solar que depén de l'alçada a la qual aquest arriba
    Real, dimension(N_d) :: Phi !Angle d'incidencia solar que depén de l'hora del dia (angle lateral)
    Real :: H_i, H_f !Hora inicial i final d'incidencia de llum solar
    Real, dimension(N_a) :: dist !Distancia terra - sol en cada dia de l'any
    

End program mov_sol