function [avaliacao_pbest, rank, velocidade, pbest, gbest, avaliacao_gbest, n_cal_erro, lbest] = treinamento(numero_de_particulas_iniciais, dimensao_das_particulas)

    
    for i=1:numero_de_particulas_iniciais
        
        avaliacao_pbest(i) = 1; %Fixando um valor para inicializa��o do vetor pbest
        
        rank(i) = 1; %Fixando um valor para inicializa��o do vetor rank
                
        for j=1:dimensao_das_particulas
            
            velocidade(i, j) = 0;      %inicializando a matriz velocidades
            pbest(i,j) = 0; %inicializando a matriz pbest
            gbest(j) = 0;    %inicializando o vetor gbest
            lbest(i,j) = 0;
        end
    end
    
    avaliacao_gbest = 1; %iniciando a vari�vel de avaliacao de gbest
    n_cal_erro = 0; % n� de c�lculo de erro relativo
end