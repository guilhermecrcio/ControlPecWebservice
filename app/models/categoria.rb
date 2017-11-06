class Categoria < ApplicationRecord
  
  self.table_name = "categorias"
  
  @protected_attributes = [
    "ativo",
    "descricao",
    "empresa_id",
    "cliente_id"
  ]
  
  @from_to = {
    "empresa_id": "empresa",
    "cliente_id": "cliente"
  }
  
  belongs_to :empresa
  belongs_to :cliente
  
  validates :descricao, presence: { message: "Descrição não informada" }
  validates :cliente, presence: { message: "Cliente inválido" }
  validates :ativo, inclusion: { in: [true, false], message: "Ativo deve ser true ou false" }
  
  validate :validate_empresa_cliente
  
end