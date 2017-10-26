class EmpresasController < ApplicationController
  
  before_action :authAppToken, :getRequestBody
  
  def novo
    return acessoNegado unless authSessaoUsuario
    
    @data["cliente_id"] = @cliente_id
    
    empresa = Empresa.new @data
    
    if empresa.valid? && empresa.save
      render json: { resultado: empresa }, status: 201
    else
      render json: { erros: empresa.errors.messages }, status: 400
    end
  end
  
  def alterar
    return acessoNegado unless authSessaoUsuario
    
    @data["cliente_id"] = @cliente_id
    
    empresa = Empresa.find_by(id: params[:empresa], cliente_id: @cliente_id)
    
    if empresa.nil?
      head :not_found
    else
      empresa.update_attributes @data
      
      if empresa.valid? && empresa.save
        render json: { resultado: empresa }, status: 200
      else
        render json: { erros: empresa.errors.messages }, status: 400
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
    
    empresas = Empresa.includes(:cidade).all.where("cliente_id = ? #{whereAtivo} ", @cliente_id)
    
    if empresas.blank?
      head :not_found
    else
      empresas = empresas.as_json(include: { cidade: @@CidadeInclude })
      empresas.map! do |e|
        estado = Estado.find(e["cidade"]["estado_id"]).as_json
        estado.delete "id"
        e["cidade"]["estado"] = estado
        e
      end
      
      render json: { resultado: empresas }, status: 200
    end
  end
  
  def busca
    return acessoNegado unless authSessaoUsuario
    
    empresa = Empresa.includes(:cidade).find_by(id: params[:empresa], cliente_id: @cliente_id)
    
    if empresa.nil?
      head :not_found
    else
      empresa = empresa.as_json(include: { cidade: @@CidadeInclude })
      estado = Estado.find(empresa["cidade"]["estado_id"]).as_json
      estado.delete "id"
      empresa["cidade"]["estado"] = estado
      
      render json: { resultado: empresa }, status: 200
    end
  end
  
end