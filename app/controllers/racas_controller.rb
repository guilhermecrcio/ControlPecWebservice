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
    
    racas = Raca.includes(:empresa, :categoria).all.where("cliente_id = ?", @cliente_id)
    
    if racas.blank?
      head :not_found
    else
      racas = racas.as_json(include: { empresa: { only: [:nome, :razao_social, :nome_fantasia, :cpf, :cnpj, :cidade_id] }, categoria: { only: [:descricao] } })
      
      render json: { resultado: racas }, status: 200
    end
  end
  
  def busca
    return acessoNegado unless authSessaoUsuario
    
    raca = Raca.includes(:empresa, :categoria).find_by(id: params[:raca], cliente_id: @cliente_id)
    
    if raca.nil?
      head :not_found
    else
      raca = raca.as_json(include: { empresa: { only: [:nome, :razao_social, :nome_fantasia, :cpf, :cnpj, :cidade_id] }, categoria: { only: [:descricao] } })
      
      render json: { resultado: raca }, status: 200
    end
  end
  
end