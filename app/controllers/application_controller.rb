class ApplicationController < ActionController::API
  
  def getRequestBody
    if request.headers["Content-Type"] == "application/json"
      data = JSON.parse request.body.read
    else
      data = params.as_json
    end
    
    data.delete "controller"
    data.delete "action"
    
    data
  end
  
end
