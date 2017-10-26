require "digest"

class Usuario < ApplicationRecord
  
  @protected_attributes = [
    "cliente_id",
    "nome",
    "telefone",
    "email",
    "senha",
    "ativo",
    "token_web",
    "token_mobile",
    "token_expiracao_mobile"
  ]
  
  @from_to = {
    "cliente_id": "cliente"
  }

  belongs_to :cliente
  
  before_create :criptografar_senha
  
  validates :cliente, presence: { message: "Cliente inválido" }
  validates :nome, presence: { message: "Nome não informado" }
  validates :telefone, presence: { message: "Telefone não informado" }
  validates :email, presence: { message: "Email não informado" }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: "Email inválido" }, if: Proc.new { |c| !c.email.nil? }
  validates :email, uniqueness: { message: "Email indisponível" }, if: Proc.new { |c| !c.email.nil? }
  validates :ativo, inclusion: { in: [true, false], message: "Ativo dever ser true ou false" }
  
  validate :forca_senha
  
  def forca_senha
    unless (!self.senha.nil? && self.senha.length >= 6 && self.senha =~ /[a-z]/i && self.senha =~ /[0-9]/)
      errors.add :senha, "A Senha deve ter no mínimo 6 caracteres e conter letras e números"
    end
  end
  
  def criptografar_senha
    if !self.senha.nil?
      self.senha = (Digest::SHA256.hexdigest self.senha)
    end
  end
  
end