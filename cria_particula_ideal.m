function [pot_borda_obj_estudo, dimensao_das_particulas] = cria_particula_ideal(cod_img, n_eletr, val_cond, valor_corrente)

% Criando imagem modelo
imdl_2d = mk_common_model(cod_img, n_eletr);  
img_22 = mk_image(imdl_2d.fwd_model,1);

dimensao_das_particulas = length(img_22.elem_data);

for i = 1:length(img_22.elem_data)
    img_22.elem_data(i) = valor_corrente;
end

% figure; show_fem(img_22,[1,1,1]); axis off
% 
% pause(3)
% 
% n_elem1 = inputdlg('Número de elementos do objeto:','IMPORTANTE!');
% n_elem = str2double(n_elem1);
% 
% for j = 1:n_elem
%      pause(1)
%      n1 = inputdlg(strcat('Número do Elemento',num2str(j),':'),'IMPORTANTE!');
%      n = str2double(n1);
%      img_22.elem_data(n) = val_cond;
% end

img_22.elem_data(92) = val_cond;
img_22.elem_data(91) = val_cond;
img_22.elem_data(90) = val_cond;
img_22.elem_data(263) = val_cond;
img_22.elem_data(265) = val_cond;
img_22.elem_data(264) = val_cond;
img_22.elem_data(89) = val_cond;
img_22.elem_data(24) = val_cond;
img_22.elem_data(264) = val_cond;
img_22.elem_data(100) = val_cond;
img_22.elem_data(248) = val_cond;
img_22.elem_data(99) = val_cond;
img_22.elem_data(364) = val_cond;

% img_22.elem_data(219) = val_cond;
% img_22.elem_data(218) = val_cond;
% img_22.elem_data(322) = val_cond;
% img_22.elem_data(323) = val_cond;
% img_22.elem_data(324) = val_cond;
% img_22.elem_data(326) = val_cond;
% img_22.elem_data(327) = val_cond;
% img_22.elem_data(400) = val_cond;
% img_22.elem_data(399) = val_cond;
% img_22.elem_data(401) = val_cond;
% img_22.elem_data(325) = val_cond;
% img_22.elem_data(328) = val_cond;
% img_22.elem_data(329) = val_cond;
% img_22.elem_data(330) = val_cond;
% img_22.elem_data(404) = val_cond;
% img_22.elem_data(403) = val_cond;
% img_22.elem_data(402) = val_cond;
% img_22.elem_data(145) = val_cond;
% img_22.elem_data(35) = val_cond;
% img_22.elem_data(17) = val_cond;
% img_22.elem_data(213) = val_cond;

% img_22.elem_data(23) = val_cond;
% img_22.elem_data(132) = val_cond;
% img_22.elem_data(24) = val_cond;
% img_22.elem_data(248) = val_cond;
% img_22.elem_data(249) = val_cond;
% img_22.elem_data(105) = val_cond;
% img_22.elem_data(103) = val_cond;
% img_22.elem_data(104) = val_cond;
% img_22.elem_data(349) = val_cond;
% img_22.elem_data(104) = val_cond;
% img_22.elem_data(106) = val_cond;
% img_22.elem_data(251) = val_cond;
% img_22.elem_data(252) = val_cond;
% img_22.elem_data(253) = val_cond;
% img_22.elem_data(250) = val_cond;
% img_22.elem_data(99) = val_cond;
% img_22.elem_data(342) = val_cond;
% img_22.elem_data(253) = val_cond;
% img_22.elem_data(252) = val_cond;
% img_22.elem_data(101) = val_cond;
% img_22.elem_data(102) = val_cond;
% img_22.elem_data(229) = val_cond;
% img_22.elem_data(334) = val_cond;
% img_22.elem_data(230) = val_cond;
% img_22.elem_data(231) = val_cond;

% Resolvendo o problema direto para o objeto de estudo
pot_borda_obj_estudo = fwd_solve(img_22);

% Mostrando objeto de estudo com distribuição de condutividade elétrica fixada pelo usuário   
figure
show_fem(img_22,[1,1]); axis off

% Salvando o resultado
saveas(gcf,'objeto_de_estudo.bmp');
        
end