class Lote < ApplicationRecord
  
  @protected_attributes = [
    "ativo",
    "categoria_id",
    "cliente_id",
    "descricao",
    "empresa_id",
    "raca_id"
  ]
  
  @from_to = {
    "categoria_id": "categoria",
    "empresa_id": "empresa",
    "cliente_id": "cliente",
    "raca_id": "raca"
  }
  
  belongs_to :empresa
  belongs_to :cliente
  belongs_to :categoria
  belongs_to :raca
  
  validates :descricao, presence: { message: "Descrição não informada" }
  validates :cliente, presence: { message: "Cliente inválido" }
  validates :ativo, inclusion: { in: [true, false], message: "Ativo dever ser true ou false" }
  
  validate :validate_categoria_cliente
  validate :validate_empresa_cliente
  validate :validate_raca_cliente
  
end