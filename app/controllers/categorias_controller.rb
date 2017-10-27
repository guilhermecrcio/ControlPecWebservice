class CategoriasController < ApplicationController
  
  before_action :authAppToken, :getRequestBody
  
  def novo
    return acessoNegado unless authSessaoUsuario
    
    @data["cliente_id"] = @cliente_id
    
    categoria = Categoria.new @data
    
    if categoria.valid? && categoria.save
      render json: { resultado: categoria }, status: 201
    else
      render json: { erros: categoria.errors.messages }, status: 400
    end
  end
  
  def alterar
    return acessoNegado unless authSessaoUsuario
    
    @data["cliente_id"] = @cliente_id
    
    categoria = Categoria.find_by(id: params[:categoria], cliente_id: @cliente_id)
    
    if categoria.nil?
      head :not_found
    else
      categoria.update_attributes @data
      
      if categoria.valid? && categoria.save
        render json: { resultado: categoria }, status: 200
      else
        render json: { erros: categoria.errors.messages }, status: 400
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
    
    categorias = Categoria.includes(:empresa).all.where("cliente_id = ? #{whereAtivo} #{whereEmpresa}", @cliente_id)
    
    if categorias.blank?
      head :not_found
    else
      categorias = categorias.as_json(include: { empresa: @@EmpresaInclude })
      
      render json: { resultado: categorias }, status: 200
    end
  end
  
  def busca
    return acessoNegado unless authSessaoUsuario
    
    categoria = Categoria.includes(:empresa).find_by(id: params[:categoria], cliente_id: @cliente_id)
    
    if categoria.nil?
      head :not_found
    else
      categoria = categoria.as_json(include: { empresa: @@EmpresaInclude })
      
      render json: { resultado: categoria }, status: 200
    end
  end
  
end