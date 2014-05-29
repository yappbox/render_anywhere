require 'spec_helper'

describe RenderAnywhere do

  class UserRenderer
    include RenderAnywhere

    def initialize(user)
      @user = user
    end

    def render_ivar
      set_instance_variable(:user, @user)
      render 'spec/views/user_ivar', :layout => false
    end

    def render_current_user
      rendering_controller.action_name = 'show'
      rendering_controller.controller_name = 'user'
      rendering_controller.current_user = @user
      render 'spec/views/current_user', :layout => false
    end

    class RenderingController < RenderAnywhere::RenderingController
      attr_accessor :controller_name
      attr_accessor :current_user
      helper_method :current_user
    end
  end

  class OtherRenderer
    include RenderAnywhere
  end

  User = Struct.new(:name)

  let(:me) { User.new("Guzman") }
  subject { UserRenderer.new(me) }

  context "#rendering_controller" do
    it "creates a RenderingController of the class nested inside the class using RenderAnywhere" do
      expect(subject.rendering_controller).to be_a(UserRenderer::RenderingController)
    end

    it "creates a RenderingController of default class" do
      expect(OtherRenderer.new.rendering_controller).to be_a(RenderAnywhere::RenderingController)
    end
  end

  context "#render" do
    it "renders with ivar" do
      expect(subject.render_ivar).to eq("The current user is Guzman.\n")
    end

    it "renders with render_current_user" do
      expect(subject.render_current_user).to eq("The current user is Guzman.\nThe controller name is user.\nThe controller action is show.\n")
    end
  end
end
