class MotivosMorteController < ApplicationController
  
  before_action :authAppToken, :getRequestBody
  
  def novo
    return acessoNegado unless authSessaoUsuario
    
    @data["cliente_id"] = @cliente_id
    
    motivo_morte = MotivoMorte.new @data
    
    if motivo_morte.valid? && motivo_morte.save
      render json: { resultado: motivo_morte }, status: 201
    else
      render json: { erros: motivo_morte.errors.messages }, status: 400
    end
  end
  
  def alterar
    return acessoNegado unless authSessaoUsuario
    
    @data["cliente_id"] = @cliente_id
    
    motivo_morte = MotivoMorte.find_by(id: params[:motivo_morte], cliente_id: @cliente_id)
    
    if motivo_morte.nil?
      head :not_found
    else
      motivo_morte.update_attributes @data
      
      if motivo_morte.valid? && motivo_morte.save
        render json: { resultado: motivo_morte }, status: 200
      else
        render json: { erros: motivo_morte.errors.messages }, status: 400
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
    
    motivos_morte = MotivoMorte.all.where("cliente_id = ? #{whereAtivo}", @cliente_id)
    
    if motivos_morte.blank?
      head :not_found
    else
      render json: { resultado: motivos_morte }, status: 200
    end
  end
  
  def busca
    return acessoNegado unless authSessaoUsuario
    
    motivo_morte = MotivoMorte.find_by(id: params[:motivo_morte], cliente_id: @cliente_id)
    
    if motivo_morte.nil?
      head :not_found
    else
      render json: { resultado: motivo_morte }, status: 200
    end
  end
  
end