require 'ostruct'

module RenderAnywhere
  class RenderingController < ActionController::Metal
    # Include all the concerns we need to make this work
    include AbstractController::Logger
    include AbstractController::Rendering
    include ActionView::Layouts if defined?(ActionView::Layouts) # Rails 4.1.x
    include AbstractController::Layouts if defined?(AbstractController::Layouts) # Rails 3.2.x, 4.0.x
    include AbstractController::Helpers
    include AbstractController::Translation
    include AbstractController::AssetPaths
    include ActionController::Caching

    # Define additional helpers, this one is for csrf_meta_tag
    helper_method :protect_against_forgery?

    # override the layout in your subclass if needed.
    layout 'application'

    # configure the different paths correctly
    def initialize(*args)
      super()

      self.class.send :include, Rails.application.routes.url_helpers

      # this is you normal rails application helper
      if defined?(ApplicationHelper)
        self.class.send :helper, ApplicationHelper
      end

      lookup_context.view_paths = ApplicationController.view_paths
      config.javascripts_dir = Rails.root.join('public', 'javascripts')
      config.stylesheets_dir = Rails.root.join('public', 'stylesheets')
      config.assets_dir = Rails.root.join('public')
      config.cache_store = ActionController::Base.cache_store
      config.relative_url_root = ActionController::Base.relative_url_root

      # same asset host as the controllers
      self.asset_host = ActionController::Base.asset_host
    end

    # we are not in a browser, no need for this
    def protect_against_forgery?
      false
    end

    # so that your flash calls still work
    def flash
      {}
    end

    # and nil request to differentiate between live and offline
    def request
      OpenStruct.new
    end

    # and params will be accessible
    def params
      {}
    end

    # so that your cookies calls still work
    def cookies
      {}
    end

  end
end
