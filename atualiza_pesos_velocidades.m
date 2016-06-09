function [polos, velocidade] = atualiza_pesos_velocidades(polos, dimensao_das_particulas, velocidade, gbest, pbest, delta, peso_de_inercia, c1, c2)

r1 = rand; %Número aleatório
r2 = rand; %Número aleatório

[p, c] = size(polos);

for i=1:p
    for j=1:dimensao_das_particulas
   
        %Atualiza Velocidades
        DIndiv = c1*r1*(pbest(i,j) - polos(i,j));
        DGlobal = c2*r2*(gbest(j) - polos(i,j));
        velocidade(i,j) = peso_de_inercia * velocidade(i, j)+DIndiv+DGlobal;
        
%         if velocidade(i,j) > vmax
%             velocidade(i,j) = vmax;
%         elseif velocidade(i,j) < -vmax;
%             velocidade(i,j) = -vmax;
%         end
        
        %Atualiza Pesos
        polos(i,j) = polos(i,j)+velocidade(i,j);
        
    end
end

end