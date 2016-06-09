function [rank] = funcao_objetivo(particula, pot_borda_ideal, codigo_imagem, numero_eletrodos, dimensao_dos_polos)
       
        % Resolvendo o problema direto para os indivíduos
        imdl_2d = mk_common_model(codigo_imagem, numero_eletrodos);  
        img_dpe = mk_image(imdl_2d.fwd_model,1);
                        
        for i=1:dimensao_dos_polos        
            img_dpe.elem_data(i) = particula(i);
        end
        
        pot_borda = fwd_solve(img_dpe);

        % Calculando a distancia euclidiana entre o potencial de borda entre o indivíduo dado e o ideal
        soma = sum((pot_borda_ideal.meas - pot_borda.meas).*(pot_borda_ideal.meas - pot_borda.meas));
        soma2 = sum(pot_borda_ideal.meas.*pot_borda_ideal.meas);
        
        Erro = sqrt(soma/soma2); % Transformando a distancia euclidiana em um valor entre 0 e 1
        rank = Erro; %Retorna a porcentagem de erro
        
end