require "digest"

class SessaoController < ApplicationController
  
  before_action :authAppToken, :getRequestBody  
  
  attr_accessor :usuario
  attr_accessor :erros
  
  def initialize
    super
    @erros = Array.new
  end
  
  def web
    begin
      login do
        @usuario.update_attribute :token_web, Digest::SHA256.hexdigest(@usuario["email"]+(Time.now.to_s))
      end
      
      @usuario.delete "token_mobile"
      @usuario.delete "token_expiracao_mobile"
      
      render json: { resultado: @usuario }, status: 201
    rescue => e
      render json: { erros: @erros }, status: 400
    end
  end
  
  def mobile
    begin
      login do
        @usuario.update_attribute :token_mobile, Digest::SHA256.hexdigest(@usuario["email"]+(Time.now.to_s))
        @usuario.update_attribute :token_expiracao_mobile, (Time.now + (72 * 60 * 60))
      end
      
      @usuario.delete "token_web"
      
      render json: { resultado: @usuario }, status: 201
    rescue => e
      render json: { erros: @erros }, status: 400
    end
  end
  
  private
  def login
    if @data["email"].nil?
      @erros << "Informe o Email"
    end
    
    if @data["senha"].nil?
      @erros << "Informe a Senha"
    end
    
    if @erros.length > 0
      raise true
    end
    
    @usuario = Usuario.find_by(
      email: @data["email"],
      senha: (Digest::SHA256.hexdigest @data["senha"])
    )
    
    if @usuario.nil?
      @erros << "Usuário inválido"
      raise true
    end
    
    yield
    
    if @usuario.save validate: false
      @usuario = @usuario.as_json
      @usuario.delete "senha"
    else
      @erros << "Erro ao efetuar login"
      raise true
    end
  end
  
end
