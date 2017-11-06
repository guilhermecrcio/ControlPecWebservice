class Animal < ApplicationRecord
  
  self.table_name = "animais"
  
  @protected_attributes = [
    "anotacoes",
    "ativo",
    "categoria_id",
    "cliente_id",
    "codigo",
    "cor_pelagem_id",
    "data_morte",
    "data_nascimento",
    "data_venda",
    "descricao",
    "empresa_id",
    "gado_leiteiro",
    "gado_morto",
    "lote_id",
    "motivo_morte_id",
    "perfil_publico",
    "raca_id",
    "reprodutor",
    "sexo"
  ]
  
  @from_to = {
    "categoria_id": "categoria",
    "cliente_id": "cliente",
    "cor_pelagem_id": "cor_pelagem",
    "empresa_id": "empresa",
    "lote_id": "lote",
    "motivo_morte_id": "motivo_morte",
    "raca_id": "raca"
  }
  
  belongs_to :categoria
  belongs_to :cliente
  belongs_to :cor_pelagem
  belongs_to :empresa
  belongs_to :lote
  belongs_to :motivo_morte
  belongs_to :raca
  
  validates :ativo, inclusion: { in: [true, false], message: "Ativo deve ser true ou false" }
  validates :cliente, presence: { message: "Cliente inválido" } 
  validates :codigo, presence: { message: "Código não informado" }
  validates :data_nascimento, presence: { message: "Data de Nascimento não informada" }
  validates :gado_leiteiro, inclusion: { in: [true, false], message: "Gato Leiteiro deve ser true ou false" }
  validates :gado_morto, inclusion: { in: [true, false], message: "Gado Morto deve ser true ou false" }
  validates :perfil_publico, inclusion: { in: [true, false], message: "Perfil Público deve ser true ou false" }
  validates :reprodutor, inclusion: { in: [true, false], message: "Reprodutor deve ser true ou false" }
  validates :sexo, inclusion: { in: ["M", "F"], message: "Sexo deve ser M(Macho) ou F(Fêmea)" }
  
  validate :validate_gado_morto
  validate :validate_datas
  
  validate :validate_categoria_cliente
  validate :validate_cor_pelagem_cliente
  validate :validate_empresa_cliente
  validate :validate_lote_cliente
  validate :validate_raca_cliente
  
  def validate_gado_morto
    unless self.gado_morto
      self.data_morte = nil
      self.motivo_morte_id = nil
    else
      if self.data_morte.nil?
        errors.add :data_morte, "Data data Morte não informada"
      end
      
      validate_motivo_morte_cliente
    end
  end
  
  def validate_datas
    if !self.data_nascimento.nil? && self.data_nascimento > Date.today
      errors.add :data_nascimento, "Data de Nascimento não pode ser superior a data de hoje"
    end
    
    if !self.data_venda.nil? && !self.data_nascimento.nil? && (self.data_venda < self.data_nascimento || self.data_venda > Date.today)
      errors.add :data_venda, "Data da Venda não pode ser inferior a data de nascimento e não pode ser superior a data de hoje"
    end
    
    if !self.data_morte.nil? && !self.data_nascimento.nil? && (self.data_morte < self.data_nascimento || self.data_morte > Date.today)
      errors.add :data_morte, "Data da Morte não pode ser inferior a data de nascimento e não pode ser superior a data de hoje"
    end
  end
  
end