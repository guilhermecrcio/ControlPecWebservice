class Raca < ApplicationRecord
  
  @@colunas = [
    "ativo",
    "descricao",
    "categoria_id",
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
    
    if data.has_key? "categoria"
      data["categoria_id"] = data["categoria"]
      data.delete "categoria"
    end
    
    data = self.protected_attributes data, @@colunas
    
    super data
  end
  
  def update_attributes data
    if data.has_key? "empresa"
      data["empresa_id"] = data["empresa"]
      data.delete "empresa"  
    end
    
    if data.has_key? "categoria"
      data["categoria_id"] = data["categoria"]
      data.delete "categoria"
    end
    
    data = Raca.protected_attributes data, Raca.colunas
    
    super data
  end
  
  belongs_to :empresa
  belongs_to :cliente
  belongs_to :categoria
  
  validates :descricao, presence: { message: "Descrição não informada" }
  validates :empresa, presence: { message: "Empresa inválida" }
  validates :cliente, presence: { message: "Cliente inválido" }
  validates :ativo, inclusion: { in: [true, false], message: "Ativo dever ser true ou false" }
  validate :categoria_cliente, if: Proc.new { |c| !c.cliente_id.nil? && !c.categoria_id.nil? }
  
  def categoria_cliente
    categoria = Categoria.find_by(id: self.categoria_id, cliente_id: self.cliente_id)
    
    if categoria.nil?
      errors.add :categoria, "Categoria inválida"
    end
  end
  
end