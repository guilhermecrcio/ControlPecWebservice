class ClientesController < ApplicationController
  
  before_action :getRequestBody
    
  def novo
    erros = Hash.new
    
    @cliente = Cliente.new @data
    @usuario = Usuario.new @data
    
    if !@cliente.valid?
      erros[:cliente] = @cliente.errors.messages
    end
    
    if !@usuario.valid?
      if @usuario.errors.messages.has_key? :cliente
        @usuario.errors.messages.delete :cliente
      end
      
      if !@usuario.errors.messages.empty?
        erros[:usuario] = @usuario.errors.messages
      end
    end
    
    if !erros.empty?
      return render json: { erros: erros }, status: 400
    end
    
    ActiveRecord::Base.transaction do
      resposta = Hash.new
      
      if @cliente.save
        resposta[:cliente] = @cliente
        @usuario[:cliente_id] = @cliente[:id]
      else
        raise ActiveRecord::Rollback
      end
      
      if @usuario.save
        @usuario = @usuario.as_json
        @usuario.delete "senha"
        @usuario.delete "token_web"
        @usuario.delete "token_mobile"
        @usuario.delete "token_expiracao_mobile"
        resposta[:usuario] = @usuario
      else
        raise ActiveRecord::Rollback
      end
      
      return render json: { resultado: resposta }, status: 201
    end
    
    return render json: { erros: ["Erro ao gravar cliente"] }, status: 400
  end
  
end