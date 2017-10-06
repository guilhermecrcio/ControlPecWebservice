require "digest"

class SessaoController < ApplicationController
  
  def login
    data = getRequestBody
    
    erros = Array.new
    
    if data["email"].nil?
      erros << "Informe o Email"
    end
    
    if data["senha"].nil?
      erros << "Informe a Senha"
    end
    
    if erros.length > 0
      return render json: { erros: erros }, status: 400
    end
    
    usuario = Usuario.find_by(
      email: data["email"],
      senha: (Digest::SHA256.hexdigest data["senha"])
    )
    
    if usuario.blank?
      erros << "Usuário inválido"
      return render json: { erros: erros }, status: 400
    end
    
    usuario.update_attribute :token_web, Digest::SHA256.hexdigest(usuario["email"]+(Time.now.to_s))
    
    if usuario.save validate: false
      usuario = usuario.as_json
      usuario.delete "senha"
      usuario.delete "token_mobile"
      usuario.delete "token_expiracao_mobile"
      render json: { resultado: usuario }, status: 201
    else
      abort usuario.errors.inspect
      erros << "Erro ao efetuar login"
      render json: { erros: erros }, status: 400
    end
  end
  
end