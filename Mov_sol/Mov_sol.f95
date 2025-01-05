program mov_sol
    Integer, parameter :: N_a = 365!Passos temporals (tot l'any)
    Integer, parameter :: N_d = 288 !Passos temporals (tot el dia)
    Real :: Theta (N_a) !Angle d'incidencia solar que depén de l'alçada a la qual aquest arriba discretitzarem per cada dia de l'any
    Real :: Phi (N_d) !Angle d'incidencia solar que depén de l'hora del dia (angle lateral), discretitzarem cada 5 min
    Real :: H_i, H_f !Hora inicial i final d'incidencia de llum solar
    Real :: dist(N_a) !Distancia terra - sol en cada dia de l'any
    Real :: pos_sol !Posició del sol vist desde la placa solar


End program mov_sol