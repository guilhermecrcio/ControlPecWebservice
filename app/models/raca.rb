class Raca < ApplicationRecord
  
  @protected_attributes = [
    "ativo",
    "descricao",
    "categoria_id",
    "empresa_id",
    "cliente_id"
  ]
  
  @from_to = {
    "categoria_id": "categoria",
    "empresa_id": "empresa",
    "cliente_id": "cliente"
  }
  
  belongs_to :empresa
  belongs_to :cliente
  belongs_to :categoria
  
  validates :descricao, presence: { message: "Descrição não informada" }
  validates :empresa, presence: { message: "Empresa inválida" }
  validates :cliente, presence: { message: "Cliente inválido" }
  validates :ativo, inclusion: { in: [true, false], message: "Ativo deve ser true ou false" }
  
  validate :validate_categoria_cliente
  validate :validate_empresa_cliente
  
end