class UsuariosController < ApplicationController
  
  before_action :getRequestBody
  
  def novo
    usuario = Usuario.new @data
    
    if usuario.valid? && usuario.save
      head :created
    else
      render json: { erros: usuario.errors.messages }, status: 400
    end
  end
  
end