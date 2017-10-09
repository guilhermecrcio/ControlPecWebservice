require "digest"

class SessaoController < ApplicationController
  
  before_action :getRequestBody  
  attr_accessor :usuario
  
  def web
    login do
      @usuario.update_attribute :token_web, Digest::SHA256.hexdigest(@usuario["email"]+(Time.now.to_s))
    end
    
    @usuario.delete "token_mobile"
    @usuario.delete "token_expiracao_mobile"
    
    render json: { resultado: @usuario }, status: 201
  end
  
  def mobile
    login do
      @usuario.update_attribute :token_mobile, Digest::SHA256.hexdigest(@usuario["email"]+(Time.now.to_s))
      @usuario.update_attribute :token_expiracao_mobile, (Time.now + (72 * 60 * 60))
    end
    
    @usuario.delete "token_web"
    
    render json: { resultado: @usuario }, status: 201
  end
  
  private
  def login
    erros = Array.new
    
    if @data["email"].nil?
      erros << "Informe o Email"
    end
    
    if @data["senha"].nil?
      erros << "Informe a Senha"
    end
    
    if erros.length > 0
      return render json: { erros: erros }, status: 400
    end
    
    @usuario = Usuario.find_by(
      email: @data["email"],
      senha: (Digest::SHA256.hexdigest @data["senha"])
    )
    
    if @usuario.blank?
      erros << "Usuário inválido"
      return render json: { erros: erros }, status: 400
    end
    
    if @usuario.blank?
      erros << "Usuário inválido"
      return render json: { erros: erros }, status: 400
    end
    
    yield
    
    if @usuario.save validate: false
      @usuario = @usuario.as_json
      @usuario.delete "senha"
    else
      erros << "Erro ao efetuar login"
      render json: { erros: erros }, status: 400
    end
  end
  
end
