class ApplicationController < ActionController::API
  
  attr_accessor :data
  
  def getRequestBody
    if request.headers["Content-Type"] == "application/json"
      @data = JSON.parse request.body.read
    else
      @data = params.as_json
    end
    
    @data.delete "controller"
    @data.delete "action"
  end
  
end
