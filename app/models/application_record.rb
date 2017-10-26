class ApplicationRecord < ActiveRecord::Base
  
  self.abstract_class = true
  
  def self.protected_attributes data
    new_data = Hash.new
    
    data.each do |k, v|
      if @protected_attributes.include? k.to_s
        new_data[k] = v
      end
    end
    
    new_data
  end
  
  def protected_attributes data
    const_class = self.to_s.gsub(/\d|\:.+|\W/, '').constantize
    const_class.protected_attributes data
  end
  
  def self.from_to data
    new_data = Hash.new
    
    data.each do |k, v|
      if @from_to.value? k.to_s
        new_data[@from_to.key k.to_s] = v
      else
        new_data[k] = v
      end
    end
    
    new_data
  end
  
  def from_to data
    const_class = self.to_s.gsub(/\d|\:.+|\W/, '').constantize
    const_class.from_to data
  end
  
  def self.new data
    super self.protected_attributes self.from_to data
  end
  
  def update_attributes data
    super self.protected_attributes self.from_to data
  end
  
  def validate_empresa_cliente
    unless self.cliente_id.nil?
      if self.empresa_id.nil?
        errors.add :empresa, "Empresa inválida"
      else
        empresa = Empresa.find_by(id: self.empresa_id, cliente_id: self.cliente_id)
        
        if empresa.nil?
          errors.add :empresa, "Empresa inválida"
        end
      end
    end
  end
  
  def validate_categoria_cliente
    unless self.cliente_id.nil?
      if self.categoria_id.nil?
        errors.add :categoria, "Categoria inválida"
      else
        categoria = Categoria.find_by(id: self.categoria_id, cliente_id: self.cliente_id)
        
        if categoria.nil?
          errors.add :categoria, "Categoria inválida"
        end
      end
    end
  end
  
  def validate_raca_cliente
    unless self.cliente_id.nil?
      if self.raca_id.nil?
        errors.add :raca, "Raça inválida"
      else
        raca = Raca.find_by(id: self.raca_id, cliente_id: self.cliente_id)
        
        if raca.nil?
          errors.add :raca, "Raça inválida"
        end
      end
    end
  end
  
end
