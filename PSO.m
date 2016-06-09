%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Algoritmo de Otimiza��o por Enxame de Part�culas    %
% Autor: Allan Rivalles Souza Feitosa                 % 
% Aluno de Mestrado em Eng. Biom�dica - CTG / UFPE    %
% Orientador: Wellington Pinheiro dos Santos          %
% Data de cria��o: 20/01/2014                         %                  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [] = PSO()    
    
    %Inicializa��o do EIDORS
    %run C://MATLAB/R2013a/bin/eidors-v3.7.1/eidors/startup.m %Inicializa��o do simulador para TIE'eidors'
       
    % Setando os Par�metros
    numero_de_particulas_iniciais = 100;        %N�mero de particulas geradas inicialmente
    resistividade_dos_elementos_escolhidos = 5; %Resistividade dos elementos escolhidos no vetor imagem
    valor_corrente = 0.1;                       %Valor da corrente utilizada na resolu��o do problema inverso  
    codigo_imagem = 'b2d2c';                    %C�digo para gerar a imagem utilizada como modelo
    numero_eletrodos = 16;                      %Numero de eletrodos da imagem a ser utilizada como modelo
    delta = 0.001;                              %Fator Delta da PSO
    c1 = 2.0992;                                %Influencia do conhecimento pr�prio
    c2 = 1.9008;                                %Influencia do conhecimento do l�der
    peso_de_inercia = 0.85;                     %Utilizado na pondera��o da velocidade das part�culas
    numero_de_iteracoes = 500;                   %Numero de iteracoes
    
    %Cria part�cula ideal para ser utilizada como objeto de compara��o na fun��o Objetivo
    [pot_ideal, dimensao_das_particulas] = cria_particula_ideal(codigo_imagem, numero_eletrodos, resistividade_dos_elementos_escolhidos, valor_corrente);
    
    %Inicializa��o das vari�veis
    [avaliacao_pbest, rank, velocidade, pbest, gbest, avaliacao_gbest,n_cal_erro, lbest] = treinamento(numero_de_particulas_iniciais, dimensao_das_particulas);
    
    %Gera particulas iniciais      
    [particulas] = gera_particulas_iniciais(dimensao_das_particulas, numero_de_particulas_iniciais);

    %Loop geral das itera��es
    for iteracao=1:numero_de_iteracoes       
    
    %Dado um conjunto de part�culas esta fun��o encontra os valores
    %de gbest (melhor part�cula) e pbest (melhor posi��o de cada particula at� agora)    
    [lbest, gbest, avaliacao_gbest, pbest, avaliacao_pbest, n_cal_erro] = atualiza_pbest_gbest(lbest, n_cal_erro, particulas, rank, pot_ideal, gbest, avaliacao_gbest, pbest, avaliacao_pbest, codigo_imagem, numero_eletrodos, numero_de_particulas_iniciais, dimensao_das_particulas);
                            
    %Mostra no console o n�mero da itera��o e a avalia��o da melhor part�cula    
    disp(['Itera��o ', int2str(iteracao), '. GBest = ', num2str(avaliacao_gbest)]);
            
    %Grava uma matriz com os numeros das itera��es em uma coluna e a
    %avalia��o do gbest na outra coluna
    Aptidao_iteracao(iteracao, 1) = iteracao;  
    Aptidao_iteracao(iteracao, 2) = avaliacao_gbest;  
    
    mat_iter_calc_gbest(iteracao, 1) = iteracao;
    mat_iter_calc_gbest(iteracao, 2) = n_cal_erro;
    mat_iter_calc_gbest(iteracao, 3) = avaliacao_gbest;
    
    %Atualiza pesos e velocidade de acordo com a express�o da PSO
    [particulas, velocidade] = atualiza_pesos_velocidades(particulas, dimensao_das_particulas, velocidade, gbest, pbest, delta, peso_de_inercia, c1, c2);
            
    %Explota a imagem do gbest e o comportamento do erro nas itera��es marcadas abaixo
    if (iteracao == 50)||(iteracao == 100)||(iteracao == 150)||(iteracao == 200)||(iteracao == 250)||(iteracao == 300)||(iteracao == 350)||(iteracao == 400)||(iteracao == 450)||(iteracao == 500)        
        gera_parcial(gbest, codigo_imagem, numero_eletrodos, valor_corrente, iteracao, dimensao_das_particulas);  
        figure
        plot(Aptidao_iteracao(:,1),Aptidao_iteracao(:,2),'*-');
        saveas(gcf,strcat('Comportamento do Erro Relativo Iter = ',num2str(iteracao),'.bmp'));
    end
    
    end
    
    dlmwrite('ERROS.csv',mat_iter_calc_gbest)      
    
end