module Prawn
  module Rails
    class Wrapper
      attr_accessor :pdf
    
      def initialize(pdf)
        self.pdf = pdf      
      end
      
      def section(options, &block)
        left = ( options.delete(:left) or 0 )
        top = ( options.delete(:top) or cursor )        
        options.merge!(:width => bounds.right) unless options[:width]
        bounding_box([left, top], options, &block)
      end
      
      def line(&block)      
        move_down 2
        yield if block_given?
        text "\n"
      end
      
      def field(s, options)      
        float do
          section(options) do
            text s
          end
        end
      end
      
      def method_missing(method, *args, &block) 
        pdf.send method, *args, &block
      end
    end
  end
end
