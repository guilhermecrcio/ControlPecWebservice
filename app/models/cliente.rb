class Cliente < ApplicationRecord

  belongs_to :cidade
  
  validates :tipo, inclusion: { in: [0, 1], message: "Tipo deve ser 0 (Pessoa Física) ou 1 (Pessoa Jurídica)" }
  validates :cidade, presence: { message: "Cidade inválida" }
  validates :endereco, presence: { message: "Endereço não informado" }
  validates :telefone, presence: { message: "Telefone não informado" }
  validates :email, presence: { message: "Email não informado" }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: "Email inválido" }, if: Proc.new { |c| !self.email.nil? }
  validates :valor_acesso, numericality: { message: "Valor de Acesso deve ser númerico" }
  validates :ativo, inclusion: { in: [true, false], message: "Ativo dever ser true ou false" }
  
  validate :pessoa_fisica, if: Proc.new { |c| c.tipo == 0 }
  validate :pessoa_juridica, if: Proc.new { |c| c.tipo == 1 }
  
  def pessoa_fisica
    if self.nome.nil?
      errors.add :nome, "Nome não informado"
    end
    
    if self.cpf.nil?
      errors.add :cpf, "CPF não informado"
    end
    
    if !self.cpf.nil? && cpf.length != 11
      errors.add :cpf, "CPF inválido"
    end
  end
  
  def pessoa_juridica
    if self.razao_social.nil?
      errors.add :razao_social, "Razão Social não informada"
    end
    
    if self.nome_fantasia.nil?
      errors.add :nome_fantasia, "Nome Fantasia não informado"
    end
    
    if self.cnpj.nil?
      errors.add :cnpj, "CNPJ não informado"
    end
    
    if !self.cnpj.nil? && cnpj.length != 14
      errors.add :cnpj, "CNPJ inválido"
    end
  end

end