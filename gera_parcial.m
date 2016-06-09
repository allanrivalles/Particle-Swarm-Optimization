function [] = gera_parcial(particula, tipo_imagem, numero_eletrodos, valor_corrente, iteracao, dimensao_das_particulas)

    imdl_2d = mk_common_model(tipo_imagem, numero_eletrodos);  
    img_22 = mk_image(imdl_2d.fwd_model,1);
    
    for j=1:dimensao_das_particulas
        img_22.elem_data(j) = particula(j);
    end
    
    potencial_borda = fwd_solve(img_22);
    
    figura_inverso = problema_inverso(tipo_imagem, numero_eletrodos, valor_corrente, potencial_borda);

    figure; show_fem(figura_inverso,[1,1]); axis off
    
    saveas(gcf,strcat('imagem_resultado_iteração',num2str(iteracao),'.bmp'));

end