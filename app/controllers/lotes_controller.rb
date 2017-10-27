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
    
    lotes = Lote.includes(:empresa, :categoria, :raca).all.where("cliente_id = ? #{whereAtivo} #{whereEmpresa} #{whereCategoria} #{whereRaca}", @cliente_id)
    
    if lotes.blank?
      head :not_found
    else
      lotes = lotes.as_json(include: { empresa: @@EmpresaInclude, categoria: @@CategoriaInclude, raca: @@RacaInclude })
      
      render json: { resultado: lotes }, status: 200
    end
  end
  
  def busca
    return acessoNegado unless authSessaoUsuario
    
    lote = Lote.includes(:empresa, :categoria, :raca).find_by(id: params[:lote], cliente_id: @cliente_id)
    
    if lote.nil?
      head :not_found
    else
      lote = lote.as_json(include: { empresa: @@EmpresaInclude, categoria: @@CategoriaInclude, raca: @@RacaInclude })
      
      render json: { resultado: lote }, status: 200
    end
  end
  
end