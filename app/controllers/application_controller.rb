class ApplicationController < ActionController::API
  
  attr_accessor :data
  
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
    if request.headers["Content-Type"] == "application/json"
      @data = JSON.parse request.body.read
    else
      @data = params.as_json
    end

    if !@data.nil?
      @data.delete "controller"
      @data.delete "action"
    end
  end
  
  def authSessaoUsuario
    if !request.headers["HTTP_X_CLIENT"].nil?
      client = request.headers["HTTP_X_CLIENT"]
    else
      client = request.headers["X_CLIENT"]
    end
    
    if !request.headers["HTTP_X_USER"].nil?
      user = request.headers["HTTP_X_USER"]
    else
      user = request.headers["X_USER"]
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
    
    if client.nil? || user.nil? || access_token.nil? || app.nil?
      return false
    end
    
    if app.upcase == "MOBILE"
      usuario = Usuario.find_by(
        cliente: client,
        id: user,
        token_mobile: access_token
      )
    else
      usuario = Usuario.find_by(
        cliente: client,
        id: user,
        token_web: access_token
      )
    end
    
    if usuario.nil?
      false
    else
      true
    end
  end
  
  def acessoNegado
    head :unauthorized
  end
  
end
