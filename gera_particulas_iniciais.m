function [particulas_iniciais] = gera_particulas_iniciais(dimensao_das_particulas, numero_de_particulas_iniciais)

for i = 1:numero_de_particulas_iniciais
        
    %preenchendo cada elemento da imagem com um valor aleatório
    for j = 1:dimensao_das_particulas
        particulas_iniciais(i,j) = (1/5)*rand(1);
    end
    
end

end