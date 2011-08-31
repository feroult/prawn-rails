require 'prawn'

require 'prawn_rails/template_handler'
require 'prawn_rails/helper'
require 'prawn_rails/wrapper'
require 'prawn_rails/highlight_callback'

#if Prawn::VERSION == "0.8.4"
#  require 'prawn/layout'
#  require 'prawn/security'
#end

Mime::Type.register_alias "application/pdf", :pdf
ActionView::Template.register_template_handler(:prawn, Prawn::Rails::TemplateHandler)
ActionView::Base.send(:include, Prawn::Rails::PrawnHelper)
