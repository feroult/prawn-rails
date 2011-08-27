module Prawn
  module Rails
    class Wrapper
      attr_accessor :pdf
    
      def initialize(pdf)
        self.pdf = pdf      
      end
      
      def section(height, &block)
        bounding_box([0, cursor], :width => bounds.right, :height => height, &block)
      end
      
      def method_missing(method, *args, &block) 
        pdf.send method, *args, &block
      end
    end
  end
end
