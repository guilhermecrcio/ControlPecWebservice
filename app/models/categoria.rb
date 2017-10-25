class Categoria < ApplicationRecord
  
  self.table_name = "categorias"
  
  @@colunas = [
    "ativo",
    "descricao",
    "empresa_id",
    "cliente_id"
  ]
  
  def self.colunas
    @@colunas
  end
  
  def self.new data
    if data.has_key? "empresa"
      data["empresa_id"] = data["empresa"]
      data.delete "empresa"
    end
    
    data = self.protected_attributes data, @@colunas
    
    super data
  end
  
  def update_attributes data
    if data.has_key? "empresa"
      data["empresa_id"] = data["empresa"]
      data.delete "empresa"  
    end
    
    data = Categoria.protected_attributes data, Categoria.colunas
    
    super data
  end
  
  belongs_to :empresa
  
  validates :descricao, presence: { message: "Descrição não informada" }
  validates :empresa, presence: { message: "Empresa inválida" }
  validates :ativo, inclusion: { in: [true, false], message: "Ativo dever ser true ou false" }
  
end