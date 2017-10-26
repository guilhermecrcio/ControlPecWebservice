class ApplicationController < ActionController::API
  
  attr_accessor :data
  attr_accessor :cliente_id
  attr_accessor :usuario_id
  
  @@EmpresaInclude   = { only: [:tipo, :nome, :razao_social, :nome_fantasia, :cpf, :cnpj, :cidade_id, :ativo] }
  @@EstadoInclude    = { only: [:uf, :nome] }
  @@CidadeInclude    = { only: [:nome, :estado_id, :latitude, :longitude] }
  @@CategoriaInclude = { only: [:descricao, :ativo] }
  @@RacaInclude      = { only: [:descricao, :ativo] }
  
  def authAppToken
    if !request.headers["HTTP_X_APP_TOKEN"].nil?
      app_token = request.headers["HTTP_X_APP_TOKEN"]
    else
      app_token = request.headers["X_APP_TOKEN"]
    end
    
    if app_token != "582a1608545f44aac1fb92987ea8384fb504bd001a871133516d202377cce23a4e815b2663963cacb671e7a7941a2b3bac7e08639e23a79284568763a7200258"
      return head :unauthorized
    end
  end
  
  def getRequestBody
    if ["POST", "PUT"].include? request.request_method
      if request.headers["Content-Type"] == "application/json"
        @data = JSON.parse request.body.read
      else
        @data = params.as_json
      end
    end

    if !@data.nil?
      @data.delete "controller"
      @data.delete "action"
    end
  end
  
  def authSessaoUsuario
    if !request.headers["HTTP_X_CLIENT"].nil?
      cliente = request.headers["HTTP_X_CLIENT"]
    else
      cliente = request.headers["X_CLIENT"]
    end
    
    if !request.headers["HTTP_X_USER"].nil?
      usuario = request.headers["HTTP_X_USER"]
    else
      usuario = request.headers["X_USER"]
    end
    
    if !request.headers["HTTP_X_ACCESS_TOKEN"].nil?
      access_token = request.headers["HTTP_X_ACCESS_TOKEN"]
    else
      access_token = request.headers["X_ACCESS_TOKEN"]
    end
    
    if !request.headers["HTTP_X_APP"].nil?
      app = request.headers["HTTP_X_APP"]
    else
      app = request.headers["X_APP"]
    end
    
    if cliente.nil? || usuario.nil? || access_token.nil? || app.nil?
      return false
    end
    
    if app.upcase == "MOBILE"
      usuario = Usuario.find_by(
        cliente: cliente,
        id: usuario,
        token_mobile: access_token
      )
    else
      usuario = Usuario.find_by(
        cliente: cliente,
        id: usuario,
        token_web: access_token
      )
    end
    
    if usuario.nil?
      false
    else
      @cliente_id = cliente
      @usuario_id = usuario
      true
    end
  end
  
  def acessoNegado
    head :unauthorized
  end
  
end
