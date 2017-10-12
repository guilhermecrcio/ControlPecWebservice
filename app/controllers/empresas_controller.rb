class EmpresasController < ApplicationController
  
  before_action :authAppToken, :getRequestBody
  
  def novo
    return acessoNegado unless authSessaoUsuario
    
    empresa = Empresa.new @data
    
    if empresa.valid? && empresa.save
      render json: { resultado: empresa }, status: 201
    else
      render json: { erros: empresa.errors.messages }, status: 400
    end
  end
  
end