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
  end

  User = Struct.new(:name)

  let(:me) { User.new("Guzman") }
  subject { UserRenderer.new(me) }

  it "renders with ivar" do
    expect(subject.render_ivar).to eq("The current user is Guzman.\n")
  end
end
