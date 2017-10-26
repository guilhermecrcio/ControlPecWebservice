class RacasController < ApplicationController
  
  before_action :authAppToken, :getRequestBody
  
  def novo
    return acessoNegado unless authSessaoUsuario
    
    @data["cliente_id"] = @cliente_id
    
    raca = Raca.new @data
    
    if raca.valid? && raca.save
      render json: { resultado: raca }, status: 201
    else
      render json: { erros: raca.errors.messages }, status: 400
    end
  end
  
  def alterar
    return acessoNegado unless authSessaoUsuario
    
    @data["cliente_id"] = @cliente_id
    
    raca = Raca.find_by(id: params[:raca], cliente_id: @cliente_id)
    
    if raca.nil?
      head :not_found
    else
      raca.update_attributes @data
      
      if raca.valid? && raca.save
        render json: { resultado: raca }, status: 200
      else
        render json: { erros: raca.errors.messages }, status: 400
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
    
    racas = Raca.includes(:empresa, :categoria).all.where("cliente_id = ? #{whereAtivo}", @cliente_id)
    
    if racas.blank?
      head :not_found
    else
      racas = racas.as_json(include: { empresa: @@EmpresaInclude, categoria: @@CategoriaInclude })  
      
      render json: { resultado: racas }, status: 200
    end
  end
  
  def busca
    return acessoNegado unless authSessaoUsuario
    
    raca = Raca.includes(:empresa, :categoria).find_by(id: params[:raca], cliente_id: @cliente_id)
    
    if raca.nil?
      head :not_found
    else
      raca = raca.as_json(include: { empresa: @@EmpresaInclude, categoria: @@CategoriaInclude })
      
      render json: { resultado: raca }, status: 200
    end
  end
  
end