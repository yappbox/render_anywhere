render_anywhere
====================

Out of the box, Rails can render templates in a controller context only. This little gem allows for calling "render" from anywhere: models, background jobs, rake tasks, you name it.

Installation
------------------

```bash
    gem install render_anywhere
```

Usage
--------------------

Put render_anywhere in your Gemfile: 

```ruby
    gem 'render_anywhere', :require => false
```

In your Rails app, in a rake task, model, background job, or where ever you like, require render_anywhere, include the module and call render with the same arguments as ActionController::Base#render takes. It will return a string.

```ruby
    require 'render_anywhere'

    class AnyClass
      include RenderAnywhere

      def build_html
        html = render :template => 'normal/template/reference',
                      :layout => 'application'
        html
      end
      # Include an additional helper
      # If being used in a rake task, you may need to require the file(s)
      # Ex: require Rails.root.join('app', 'helpers', 'blog_pages_helper')
      def include_helper(helper_name)
        set_render_anywhere_helpers(helper_name)
      end

      # Apply an instance variable to the controller
      # If you need to use instance variables instead of locals, just call this method as many times as you need.
      def set_instance_variable(var, value)
        set_instance_variable(var, value)
      end

      class RenderingController < RenderAnywhere::RenderingController
        # include custom modules here, define accessors, etc. For example:
        attr_accessor :current_user
        helper_method :current_user
      end

      # If you define custom RenderingController, don't forget to override this method
      def rendering_controller
        @rendering_controller ||= self.class.const_get("RenderingController").new
      end
    end
```

Thanks
--------------------

[Yapp](http://yapp.us), whose CTO (me) kindly agreed to open source this library. App yourself!

The basic approach used here came from [this gist](https://gist.github.com/977181) by [Julien Guimont aka juggy](https://github.com/juggy). Thanks!

Contributing
--------------------

Run tests with `rake` or `rspec`.

Run tests against different versions of rails with `appraisal rake` or `appraisal rspec`.

Author
--------------------

Luke Melia, [@lukemelia](https://twitter.com/lukemelia), [lukemelia.com](http://lukemelia.com)

License
--------------------

The MIT License. Copyright (c) 2011, Yapp, Inc.
