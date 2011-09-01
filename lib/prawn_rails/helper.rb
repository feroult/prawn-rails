module Prawn
  module Rails
    module PrawnHelper          
      def prawn_document(opts={}, &block)            
        download = opts.delete(:force_download)
        filename = opts.delete(:filename)

        @pdf = (opts.delete(:renderer) || Prawn::Document).new(opts)
        yield if block_given?
        
        disposition(download, filename) if (download || filename)
        
        @pdf
      end
      
      def disposition(download, filename)
        download = true if (filename && download == nil)
        disposition = download ? "attachment;" : "inline;"
        disposition += " filename=\"#{filename}\"" if filename
        headers["Content-Disposition"] = disposition
      end
      
      def box(options = {}, &block)
        left = ( options.delete(:left) or 0 )
        top = ( options.delete(:top) or cursor )        
        options.merge!(:width => bounds.right) unless options[:width]
        bounding_box([left, top], options, &block)
      end
      
      def section(&block)
        stroke_horizontal_rule
        move_down 3
        yield block if block_given?       
        #box(options, &block)
        move_down 5 
      end
      
      def line(&block)      
        move_down 2
        yield if block_given?
        text "\n"
      end
      
      def field(s, options = {})      
        float do        
          label = options.delete(:label)
          align = ( options.delete(:align) or :left )
          highlight = ( options.delete(:highlight) or false )         
          
          box(options) do          
            highlight_text(text_with_label(s, label)) if highlight 
            text formatted_text_with_label(s, label), :inline_format => true, :align => align
          end
        end
      end

      def highlight_text(s)      
        width = width_of(s)
        height = height_of(s)
      
        original_color = fill_color
        @pdf.fill_color = "ffff00"
        @pdf.fill_rectangle([bounds.left-2, bounds.top+2], width+4, height)
        @pdf.fill_color = original_color             
      end

      def text_with_label(s, label)       
        label.nil? ? s : "#{label}: #{s}"
      end

      def formatted_text_with_label(s, label)          
        label.nil? ? s : "<b>#{label}:</b> #{s}"
      end
      
      def method_missing(method, *args, &block) 
        @pdf.send method, *args, &block
      end      
    end
  end
end

