class ApplicationRecord < ActiveRecord::Base
  
  self.abstract_class = true
  
  def self.protected_attributes data, protected_attributes
    new_data = Hash.new
    
    data.each do |k, v|
      if protected_attributes.include? k
        new_data[k] = v
      end
    end
    
    new_data
  end
  
end
