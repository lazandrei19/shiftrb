require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  describe "GET #Index" do
    it "should return index" do
      expect(response).to render_template(:index)
    end
  end
end
