require 'abstract_controller'
require 'action_view'

require 'render_anywhere/version'
require 'render_anywhere/rendering_controller'

module RenderAnywhere
  def render(*args)
    rendering_controller.render_to_string(*args)
  end

  def set_render_anywhere_helpers(*args)
    args.each do |helper_name|
      rendering_controller.class_eval do
        helper helper_name.to_s.constantize
      end
    end
  end

  def set_instance_variable(var, value)
    rendering_controller.class_eval do
      attr_accessor :"#{var}"
    end
    rendering_controller.public_send("#{var}=", value)
  end

  def rendering_controller
    @rendering_controller ||= self.class.const_get("RenderingController").new
  end
end
