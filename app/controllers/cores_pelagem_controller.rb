class CoresPelagemController < ApplicationController
  
  before_action :authAppToken, :getRequestBody
  
  def novo
    return acessoNegado unless authSessaoUsuario
    
    @data["cliente_id"] = @cliente_id
    
    cor_pelagem = CorPelagem.new @data
    
    if cor_pelagem.valid? && cor_pelagem.save
      render json: { resultado: cor_pelagem }, status: 201
    else
      render json: { erros: cor_pelagem.errors.messages }, status: 400
    end
  end
  
  def alterar
    return acessoNegado unless authSessaoUsuario
    
    @data["cliente_id"] = @cliente_id
    
    cor_pelagem = CorPelagem.find_by(id: params[:cor_pelagem], cliente_id: @cliente_id)
    
    if cor_pelagem.nil?
      head :not_found
    else
      cor_pelagem.update_attributes @data
      
      if cor_pelagem.valid? && cor_pelagem.save
        render json: { resultado: cor_pelagem }, status: 200
      else
        render json: { erros: cor_pelagem.errors.messages }, status: 400
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
    
    unless params["empresa"].nil?
      whereEmpresa = "AND empresa_id = #{params['empresa']}"
    end
    
    unless params["categoria"].nil?
      whereCategoria = "AND categoria_id = #{params['categoria']}"
    end
    
    unless params["raca"].nil?
      whereRaca = "AND raca_id = #{params['raca']}"
    end
    
    cores_pelagem = CorPelagem.includes(:empresa, :categoria, :raca).all.where("cliente_id = ? #{whereAtivo} #{whereEmpresa} #{whereCategoria} #{whereRaca}", @cliente_id)
    
    if cores_pelagem.blank?
      head :not_found
    else
      cores_pelagem = cores_pelagem.as_json(include: { empresa: @@EmpresaInclude, categoria: @@CategoriaInclude, raca: @@RacaInclude })
      
      render json: { resultado: cores_pelagem }, status: 200
    end
  end
  
  def busca
    return acessoNegado unless authSessaoUsuario
    
    cor_pelagem = CorPelagem.includes(:empresa, :categoria, :raca).find_by(id: params[:cor_pelagem], cliente_id: @cliente_id)
    
    if cor_pelagem.nil?
      head :not_found
    else
      cor_pelagem = cor_pelagem.as_json(include: { empresa: @@EmpresaInclude, categoria: @@CategoriaInclude, raca: @@RacaInclude })
      
      render json: { resultado: cor_pelagem }, status: 200
    end
  end
  
end