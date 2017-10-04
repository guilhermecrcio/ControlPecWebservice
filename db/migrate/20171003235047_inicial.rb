class Inicial < ActiveRecord::Migration[5.1]
  def change
    create_table :estados do |t|
      t.column :uf, :string, null: false, limit: 2
      t.column :nome, :text, null: false
    end
    
    create_table :cidades do |t|
      t.column :nome, :text, null: false
      t.column :latitude, :float, null: false
      t.column :longitude, :float, null: false
      t.references :estados, null: false, index: true
    end

    create_table :clientes do |t|
      t.column :tipo, :integer, null: false, limit: 1
      t.column :nome, :text, null: true
      t.column :razao_social, :text, null: true
      t.column :nome_fantasia, :text, null: true
      t.column :cpf, :string, null: true, limit: 11
      t.column :cnpj, :string, null: true, limit: 14
      t.references :cidades, null: false, index: true
      t.column :endereco, :text, null: false
      t.column :telefone, :text, null: false
      t.column :email, :text, null: false
      t.column :valor_acesso, :decimal, null: false
      t.column :ativo, :boolean, null: false, default: true, index: true
      
      t.timestamps
    end
    
    create_table :usuarios do |t|
      t.references :clientes, null: false, index: true
      t.column :nome, :text, null: false
      t.column :telefone, :text, null: false
      t.column :email, :text, null: false, index: true
      t.column :senha, :text, null: false, index: true
      t.column :ativo, :boolean, null: false, default: true, index: true
      t.column :token_web, :text, null: true, index: true
      t.column :token_mobile, :text, null: true, index: true
      t.column :token_expiracao_mobile, :timestamp, null: true, index: true
      
      t.timestamps
    end
  end
end
