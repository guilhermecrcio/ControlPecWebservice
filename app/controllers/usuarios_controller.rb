class UsuariosController < ApplicationController
  
  def novo
    usuario = Usuario.new getRequestBody
    
    if usuario.valid? && usuario.save
      head :created
    else
      render json: { erros: usuario.errors.messages }, status: 400
    end
  end
  
end