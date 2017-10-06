class ClientesController < ApplicationController
    
  def novo
    cliente = Cliente.new getRequestBody
    
    if cliente.valid? && cliente.save
      head :created
    else
      render json: { erros: cliente.errors.messages }, status: 400
    end
  end
  
end