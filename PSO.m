%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Algoritmo de Otimização por Enxame de Partículas    %
% Autor: Allan Rivalles Souza Feitosa                 % 
% Aluno de Mestrado em Eng. Biomédica - CTG / UFPE    %
% Orientador: Wellington Pinheiro dos Santos          %
% Data de criação: 20/01/2014                         %                  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [] = PSO()    
    
    %Inicialização do EIDORS
    %run C://MATLAB/R2013a/bin/eidors-v3.7.1/eidors/startup.m %Inicialização do simulador para TIE'eidors'
       
    % Setando os Parâmetros
    numero_de_particulas_iniciais = 100;        %Número de particulas geradas inicialmente
    resistividade_dos_elementos_escolhidos = 5; %Resistividade dos elementos escolhidos no vetor imagem
    valor_corrente = 0.1;                       %Valor da corrente utilizada na resolução do problema inverso  
    codigo_imagem = 'b2d2c';                    %Código para gerar a imagem utilizada como modelo
    numero_eletrodos = 16;                      %Numero de eletrodos da imagem a ser utilizada como modelo
    delta = 0.001;                              %Fator Delta da PSO
    c1 = 2.0992;                                %Influencia do conhecimento próprio
    c2 = 1.9008;                                %Influencia do conhecimento do líder
    peso_de_inercia = 0.85;                     %Utilizado na ponderação da velocidade das partículas
    numero_de_iteracoes = 500;                   %Numero de iteracoes
    
    %Cria partícula ideal para ser utilizada como objeto de comparação na função Objetivo
    [pot_ideal, dimensao_das_particulas] = cria_particula_ideal(codigo_imagem, numero_eletrodos, resistividade_dos_elementos_escolhidos, valor_corrente);
    
    %Inicialização das variáveis
    [avaliacao_pbest, rank, velocidade, pbest, gbest, avaliacao_gbest,n_cal_erro, lbest] = treinamento(numero_de_particulas_iniciais, dimensao_das_particulas);
    
    %Gera particulas iniciais      
    [particulas] = gera_particulas_iniciais(dimensao_das_particulas, numero_de_particulas_iniciais);

    %Loop geral das iterações
    for iteracao=1:numero_de_iteracoes       
    
    %Dado um conjunto de partículas esta função encontra os valores
    %de gbest (melhor partícula) e pbest (melhor posição de cada particula até agora)    
    [lbest, gbest, avaliacao_gbest, pbest, avaliacao_pbest, n_cal_erro] = atualiza_pbest_gbest(lbest, n_cal_erro, particulas, rank, pot_ideal, gbest, avaliacao_gbest, pbest, avaliacao_pbest, codigo_imagem, numero_eletrodos, numero_de_particulas_iniciais, dimensao_das_particulas);
                            
    %Mostra no console o número da iteração e a avaliação da melhor partícula    
    disp(['Iteração ', int2str(iteracao), '. GBest = ', num2str(avaliacao_gbest)]);
            
    %Grava uma matriz com os numeros das iterações em uma coluna e a
    %avaliação do gbest na outra coluna
    Aptidao_iteracao(iteracao, 1) = iteracao;  
    Aptidao_iteracao(iteracao, 2) = avaliacao_gbest;  
    
    mat_iter_calc_gbest(iteracao, 1) = iteracao;
    mat_iter_calc_gbest(iteracao, 2) = n_cal_erro;
    mat_iter_calc_gbest(iteracao, 3) = avaliacao_gbest;
    
    %Atualiza pesos e velocidade de acordo com a expressão da PSO
    [particulas, velocidade] = atualiza_pesos_velocidades(particulas, dimensao_das_particulas, velocidade, gbest, pbest, delta, peso_de_inercia, c1, c2);
            
    %Explota a imagem do gbest e o comportamento do erro nas iterações marcadas abaixo
    if (iteracao == 50)||(iteracao == 100)||(iteracao == 150)||(iteracao == 200)||(iteracao == 250)||(iteracao == 300)||(iteracao == 350)||(iteracao == 400)||(iteracao == 450)||(iteracao == 500)        
        gera_parcial(gbest, codigo_imagem, numero_eletrodos, valor_corrente, iteracao, dimensao_das_particulas);  
        figure
        plot(Aptidao_iteracao(:,1),Aptidao_iteracao(:,2),'*-');
        saveas(gcf,strcat('Comportamento do Erro Relativo Iter = ',num2str(iteracao),'.bmp'));
    end
    
    end
    
    dlmwrite('ERROS.csv',mat_iter_calc_gbest)      
    
end