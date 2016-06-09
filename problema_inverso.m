function [figura_inverso] = problema_inverso (tipo_imagem, numero_eletrodos, valor_corrente, potencial_borda)

    %Criando Imagem Modelo
    imdl_2d = mk_common_model(tipo_imagem, numero_eletrodos);  
    sim_img = mk_image(imdl_2d.fwd_model,1);
    img_222 = sim_img;

    % Fixando o padrão de estimulação de corrente 
    stim =  mk_stim_patterns(numero_eletrodos,1,'{ad}','{ad}',{},valor_corrente);
    img_222.fwd_model.stimulation = stim;
    img_222.elem_data = zeros(length(img_222.elem_data),1)+1e-01;

    % Resolvendo o problema direto para distribuição de condutividade homogênea
    vh_data = fwd_solve(img_222);

    % Resolvendo o problema direto para distribuição de condutividade não-homogênea
    vi_data = potencial_borda;

    % Calculando a distribuição de condutividade no interior do objeto
    imdl_2d.reconst_type = 'difference';
    figura_inverso = inv_solve(imdl_2d, vh_data, vi_data); %Retorna imagem objetivo

end