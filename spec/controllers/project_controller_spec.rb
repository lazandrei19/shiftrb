require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  render_views
  login_user

  describe "GET #Index" do
    before do
      get :index
    end

    it "should return index" do
      expect(response).to render_template("index")
    end
  end
end
