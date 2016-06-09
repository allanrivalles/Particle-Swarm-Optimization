function [lbest, gbest, avaliacao_gbest, pbest, avaliacao_pbest ,n_cal_erro] = atualiza_pbest_gbest(lbest, n_cal_erro, particulas, rank, pot_ideal, gbest, avaliacao_gbest, pbest, avaliacao_pbest, cod_img, n_elet, numero_de_particulas_iniciais, dimensao_das_particulas)
          
    for i=1:numero_de_particulas_iniciais %Calcula a aptidão dos pesos atuais
        for j=1:dimensao_das_particulas
            particula_atual(j) = particulas(i,j);
        end
        rank(i) = funcao_objetivo(particula_atual, pot_ideal, cod_img, n_elet, dimensao_das_particulas);        
        n_cal_erro = n_cal_erro + 1;
    end
        
    for i = 1:numero_de_particulas_iniciais
                
        %Buscando gbest
        if rank(i) < avaliacao_gbest
            for j=1:dimensao_das_particulas
                gbest(j) = particulas(i,j);
            end
            avaliacao_gbest = rank(i);
        end
        
        %Atualiando, se existir os pbest
        if rank(i) < avaliacao_pbest(i)
            for j=1:dimensao_das_particulas
                pbest(i,j) = particulas(i,j);
            end
            avaliacao_pbest(i) = rank(i);
        end  
        
    end      
   
end