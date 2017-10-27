class MotivoMorte < ApplicationRecord
  
  self.table_name = "motivos_morte"
  
  @protected_attributes = [
    "ativo",
    "descricao",
    "cliente_id"
  ]
  
  @from_to = {
    "cliente_id": "cliente"
  }
  
  belongs_to :cliente
  
  validates :descricao, presence: { message: "Descrição não informada" }
  validates :cliente, presence: { message: "Cliente inválido" }
  validates :ativo, inclusion: { in: [true, false], message: "Ativo dever ser true ou false" }
  
end