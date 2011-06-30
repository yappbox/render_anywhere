module RenderAnywhere
  class RenderingController < AbstractController::Base
    # Include all the concerns we need to make this work
    include AbstractController::Logger
    include AbstractController::Rendering
    include AbstractController::Layouts
    include AbstractController::Helpers
    include AbstractController::Translation
    include AbstractController::AssetPaths
    include Rails.application.routes.url_helpers

    # this is you normal rails application helper
    helper ApplicationHelper

    # Define additional helpers, this one is for csrf_meta_tag
    helper_method :protect_against_forgery?

    # override the layout in your subclass if needed.
    layout 'application'

    # configure the different paths correctly
    def initialize(*args)
      super()
      lookup_context.view_paths = Rails.root.join('app', 'views')
      config.javascripts_dir = Rails.root.join('public', 'javascripts')
      config.stylesheets_dir = Rails.root.join('public', 'stylesheets')
      config.assets_dir = Rails.root.join('public')
    end

    # we are not in a browser, no need for this
    def protect_against_forgery?
      false
    end

    # so that your flash calls still work
    def flash
      {}
    end

    # same asset host as the controllers
    self.asset_host = ActionController::Base.asset_host

    # and nil request to differentiate between live and offline
    def request
      nil
    end
  end
end