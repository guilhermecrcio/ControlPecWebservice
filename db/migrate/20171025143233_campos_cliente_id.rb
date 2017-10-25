class CamposClienteId < ActiveRecord::Migration[5.1]
  def change
    
    change_table :categorias do |t|
      t.references :cliente, null: false, index: true
    end
    
    change_table :lotes do |t|
      t.references :cliente, null: false, index: true
    end
    
    change_table :racas do |t|
      t.references :cliente, null: false, index: true
    end
    
    change_table :cores_pelagem do |t|
      t.references :cliente, null: false, index: true
    end
    
  end
end
