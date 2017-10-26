class LotesController < ApplicationController
  
  before_action :authAppToken, :getRequestBody
  
  def novo
    return acessoNegado unless authSessaoUsuario
    
    @data["cliente_id"] = @cliente_id
    
    lote = Lote.new @data
    
    if lote.valid? && lote.save
      render json: { resultado: lote }, status: 201
    else
      render json: { erros: lote.errors.messages }, status: 400
    end
  end
  
  def alterar
    return acessoNegado unless authSessaoUsuario
    
    @data["cliente_id"] = @cliente_id
    
    lote = Lote.find_by(id: params[:lote], cliente_id: @cliente_id)
    
    if lote.nil?
      head :not_found
    else
      lote.update_attributes @data
      
      if lote.valid? && lote.save
        render json: { resultado: lote }, status: 200
      else
        render json: { erros: lote.errors.messages }, status: 400
      end
    end
  end
  
  def lista
    return acessoNegado unless authSessaoUsuario
    
    lotes = Lote.includes(:empresa, :categoria, :raca).all.where("cliente_id = ?", @cliente_id)
    
    if lotes.blank?
      head :not_found
    else
      lotes = lotes.as_json(include: { empresa: { only: [:nome, :razao_social, :nome_fantasia, :cpf, :cnpj, :cidade_id] }, categoria: { only: [:descricao] }, raca: { only: [:descricao] } })
      
      render json: { resultado: lotes }, status: 200
    end
  end
  
  def busca
    return acessoNegado unless authSessaoUsuario
    
    lote = Lote.includes(:empresa, :categoria, :raca).find_by(id: params[:lote], cliente_id: @cliente_id)
    
    if lote.nil?
      head :not_found
    else
      lote = lote.as_json(include: { empresa: { only: [:nome, :razao_social, :nome_fantasia, :cpf, :cnpj, :cidade_id] }, categoria: { only: [:descricao] }, raca: { only: [:descricao] } })
      
      render json: { resultado: lote }, status: 200
    end
  end
  
end