class ClientesController < ApplicationController
  
  before_action :getRequestBody
    
  def novo
    cliente = Cliente.new @data
    
    if cliente.valid? && cliente.save
      render json: { resultado: cliente }, status: 201
    else
      render json: { erros: cliente.errors.messages }, status: 400
    end
  end
  
end