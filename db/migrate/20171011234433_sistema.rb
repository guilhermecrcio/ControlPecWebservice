class Sistema < ActiveRecord::Migration[5.1]
  def change
    create_table :empresas do |t|
      t.references :cliente, null: false, index: true
      t.column :tipo, :integer, null: false, limit: 1
      t.column :nome, :text, null: true
      t.column :cpf, :string, null: true, limit: 11
      t.column :razao_social, :text, null: true
      t.column :nome_fantasia, :text, null: true
      t.column :cnpj, :string, null: true, limit: 14
      t.column :endereco, :text, null: false
      t.references :cidade, null: false, index: true
      t.column :telefone, :text, null: false
      t.column :email, :text, null: false
      t.column :ativo, :boolean, null: false, default: true, index: true
      
      t.timestamps
    end
    
    create_table :categorias do |t|
      t.references :empresa, null: false, index: true
      t.column :descricao, :text, null: false
      t.column :ativo, :boolean, null: false, default: true, index: true
      
      t.timestamps
    end
    
    create_table :racas do |t|
      t.references :empresa, null: false, index: true
      t.references :categoria, null: false, inde: true
      t.column :descricao, :text, null: false
      t.column :ativo, :boolean, null: false, default: true, index: true
      
      t.timestamps
    end
    
    create_table :lotes do |t|
      t.references :empresa, null: false, index: true
      t.references :categoria, null: false, index: true
      t.references :raca, null: false, index: true
      t.column :descricao, :text, null: false
      t.column :ativo, :boolean, null: false, default: true, index: true
      
      t.timestamps
    end
    
    create_table :cores_pelagem do |t|
      t.references :empresa, null: false, index: true
      t.references :categoria, null: false, index: true
      t.references :raca, null: false, index: true
      t.column :descricao, :text, null: false
      t.column :ativo, :boolean, null: false, default: true, index: true
      
      t.timestamps
    end
    
    create_table :motivos_morte do |t|
      t.references :cliente, null: false, index: true
      t.column :descricao, :text, null: false
      t.column :ativo, :boolean, null: false, default: true, index: true
      
      t.timestamps
    end
    
    create_table :animais do |t|
      t.references :cliente, null: false, index: true
      t.references :empresa, null: false, index: true
      t.references :categoria, null: false, index: true
      t.references :raca, null: false, index: true
      t.references :lote, null: false, index: true
      t.column :codigo, :text, null: false, index: true
      t.column :descricao, :text, null: true
      t.column :data_nascimento, :date, null: false, index: true
      t.column :data_morte, :date, null: true, index: true
      t.column :data_venda, :date, null: true, index: true  
      t.references :cor_pelagem, null: false, index: true
      t.column :sexo, :string, null: false, limit: 1, index: true
      t.column :anotacoes, :text, null: true
      t.column :gado_leiteiro, :boolean, null: false, defaut: false, index: true
      t.column :gado_morto, :boolean, null: false, default: false, index: true
      t.column :reprodutor, :boolean, null: false, default: false, index: true
      t.references :motivo_morte, null: true, index: true
      t.column :ativo, :boolean, null: false, default: true, index: true
      t.column :perfil_publico, :boolean, null: false, default: false, index: true
      
      t.timestamps
    end
    
    create_table :pesos_animal do |t|
      t.references :animal, null: false, index: true
      t.column :peso, :decimal, null: false
      t.column :anotacoes, :text, null: true
      t.column :ativo, :boolean, null: false, default: true, index: true
      
      t.timestamps
    end
    
    create_table :medidas_animal do |t|
      t.references :animal, null: false, index: true
      t.column :altura, :decimal, null: false
      t.column :comprimento_corporal, :decimal, null: false
      t.column :circunferencia_escrotal, :decimal, null: false
      t.column :comprimento_garupa, :decimal, null: false
      t.column :largura_garupa, :decimal, null: false
      t.column :perimetro_toracico, :decimal, null: false
      t.column :profundidade_costela, :decimal, null: false
      t.column :ativo, :boolean, null: false, default: true, index: true
      
      t.timestamps
    end
    
    create_table :ordenhas_animal do |t|
      t.references :animal, null: false, index: true
      t.column :litros_leite, :decimal, null: false
      t.column :anotacoes, :text, null: true
      t.column :ativo, :boolean, null: false, default: true, index: true
      
      t.timestamps
    end
  end
end
