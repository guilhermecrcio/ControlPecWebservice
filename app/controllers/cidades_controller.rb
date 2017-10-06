class CidadesController < ApplicationController
  
  def filtroPorUf
    cidades = Cidade.includes(:estado).joins(:estado).all.where("estados.uf = ?", params[:uf].upcase).order("cidades.nome ASC")
    
    if cidades.blank?
      head :not_found
    else
      render json: { resultado: cidades.as_json(include: { estado: { only: [:uf, :nome] } }) }, status: 200
    end
  end
  
end