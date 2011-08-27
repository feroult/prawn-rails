module Prawn
  module Rails
    module PrawnHelper      
      def prawn_document(opts={}, &block)
        download = opts.delete(:force_download)
        filename = opts.delete(:filename)
        pdf = (opts.delete(:renderer) || Prawn::Document).new(opts)
        Prawn::Rails::Wrapper.new(pdf).instance_eval(&block) if block_given?
        #pdf.instance_eval(&block) if block_given?
        
        disposition(download, filename) if (download || filename)
        
        pdf
      end
      
      def disposition(download, filename)
        download = true if (filename && download == nil)
        disposition = download ? "attachment;" : "inline;"
        disposition += " filename=\"#{filename}\"" if filename
        headers["Content-Disposition"] = disposition
      end
    end
  end
end

