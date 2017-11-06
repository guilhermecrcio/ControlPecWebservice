class AnimaisController < ApplicationController
  
  before_action :authAppToken, :getRequestBody
  
  def novo
    return acessoNegado unless authSessaoUsuario
    
    @data["cliente_id"] = @cliente_id
    
    animal = Animal.new @data
    
    if animal.valid? && animal.save
      render json: { resultado: animal }, status: 201
    else
      render json: { erros: animal.errors.messages }, status: 400
    end
  end
  
  def alterar
    return acessoNegado unless authSessaoUsuario
    
    @data["cliente_id"] = @cliente_id
    
    animal = Animal.find_by(id: params[:animal], cliente_id: @cliente_id)
    
    if animal.nil?
      head :not_found
    else
      animal.update_attributes @data
      
      if animal.valid? && animal.save
        render json: { resultado: animal }, status: 200
      else
        render json: { erros: animal.errors.messages }, status: 400
      end
    end
  end
  
  def lista
    return acessoNegado unless authSessaoUsuario
    
    unless params["ativo"].nil?
      unless ["false", "true"].include? params["ativo"].downcase
        return head :bad_request
      end
      
      whereAtivo = "AND ativo IS #{params['ativo']}"
    end
    
    unless params["gado_leiteiro"].nil?
      unless ["false", "true"].include? params["gado_leiteiro"].downcase
        return head :bad_request
      end
      
      whereGadoLeiteiro = "AND gado_leiteiro IS #{params['gado_leiteiro']}"
    end
    
    unless params["gado_morto"].nil?
      unless ["false", "true"].include? params["gado_morto"].downcase
        return head :bad_request
      end
      
      whereGadoMorto = "AND gado_morto IS #{params['gado_morto']}"
    end
    
    unless params["reprodutor"].nil?
      unless ["false", "true"].include? params["reprodutor"].downcase
        return head :bad_request
      end
      
      whereReprodutor = "AND reprodutor IS #{params['reprodutor']}"
    end
    
    unless params["sexo"].nil?
      unless ["M", "F"].include? params["sexo"].upcase
        return head :bad_request
      end
      
      params["sexo"].upcase!
      
      whereSexo = "AND sexo = '#{params['sexo']}'"
    end
    
    unless params["data_morte_inicial"].nil? && params["data_morte_final"].nil?
      begin
        data_inicial = Date.strptime params["data_morte_inicial"], "%Y-%m-%d"
        data_final   = Date.strptime params["data_morte_final"], "%Y-%m-%d"
        
        return head :bad_request if data_inicial.strftime("%s") > data_final.strftime("%s")
      rescue
        return head :bad_request
      end
      
      whereDataMorte = "AND (data_morte BETWEEN '#{params['data_morte_inicial']}' AND '#{params['data_morte_final']}' )"
    end
    
    unless params["data_nascimento_inicial"].nil? && params["data_nascimento_final"].nil?
      begin
        data_inicial = Date.strptime params["data_nascimento_inicial"], "%Y-%m-%d"
        data_final   = Date.strptime params["data_nascimento_final"], "%Y-%m-%d"
        
        return head :bad_request if data_inicial.strftime("%s") > data_final.strftime("%s")
      rescue
        return head :bad_request
      end
      
      whereDataNascimento = "AND (data_nascimento BETWEEN '#{params['data_nascimento_inicial']}' AND '#{params['data_nascimento_final']}' )"
    end
    
    unless params["data_venda_inicial"].nil? && params["data_venda_final"].nil?
      begin
        data_inicial = Date.strptime params["data_venda_inicial"], "%Y-%m-%d"
        data_final   = Date.strptime params["data_venda_final"], "%Y-%m-%d"
        
        return head :bad_request if data_inicial.strftime("%s") > data_final.strftime("%s")
      rescue
        return head :bad_request
      end
      
      whereDataVenda = "AND (data_venda BETWEEN '#{params['data_venda_inicial']}' AND '#{params['data_venda_final']}' )"
    end
    
    whereCategoria   = "AND categoria_id = #{params['categoria']}" unless params["categoria"].nil?
    whereCorPelagem  = "AND cor_pelagem_id = #{params['cor_pelagem']}" unless params["cor_pelagem"].nil?
    whereEmpresa     = "AND empresa_id = #{params['empresa']}" unless params["empresa"].nil?
    whereLote        = "AND lote_id = #{params['lote']}" unless params["lote"].nil?
    whereMotivoMorte = "AND motivo_morte_id = #{params['motivo_morte']}" unless params["motivo_morte"].nil?
    whereRaca        = "AND raca_id = #{params['raca']}" unless params["raca"].nil?
    
    params["pagina"] = 1 if params["pagina"] == 0
    
    limit = 50
    offset = limit * (params["pagina"].to_i - 1)
    
    animais = Animal.includes(:categoria, :cor_pelagem, :empresa, :lote, :motivo_morte, :raca).all.where("cliente_id = ? #{whereAtivo} #{whereGadoLeiteiro} #{whereGadoMorto} #{whereReprodutor} #{whereSexo} #{whereCategoria} #{whereCorPelagem} #{whereEmpresa} #{whereLote} #{whereMotivoMorte} #{whereRaca} #{whereDataMorte} #{whereDataNascimento} #{whereDataVenda}", @cliente_id).limit(limit).offset(offset)
    
    if animais.blank?
      head :not_found
    else
      animais = animais.as_json(include: { categoria: @@CategoriaInclude, cor_pelagem: @@CorPelagemInclude, empresa: @@EmpresaInclude, lote: @@LoteInclude, motivo_morte: @@MotivoMorteInclude, raca: @@RacaInclude })
      
      render json: { resultado: animais }, status: 200
    end
  end
  
  def busca
    return acessoNegado unless authSessaoUsuario
    
    animal = Animal.includes(:categoria, :cor_pelagem, :empresa, :lote, :motivo_morte, :raca).find_by(id: params[:animal], cliente_id: @cliente_id)
    
    if animal.nil?
      head :not_found
    else
      animal = animal.as_json(include: { categoria: @@CategoriaInclude, cor_pelagem: @@CorPelagemInclude, empresa: @@EmpresaInclude, lote: @@LoteInclude, motivo_morte: @@MotivoMorteInclude, raca: @@RacaInclude })
      
      render json: { resultado: animal }, status: 200
    end
  end
  
end