module Prawn
  module Rails
    class TemplateHandler
      class_attribute :default_format
      self.default_format = :pdf
      
      def self.call(template)
        "#{template.source.strip}.render"        
      end
    end
  end  
end
    
