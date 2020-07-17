require 'rails_helper'

RSpec.describe PowerGeneratorsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #show" do
    power_generator = FactoryBot.create(:power_generator)
    it "returns http success" do
      get :show, params: { id: power_generator.id }
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #list" do
    it "returns http success" do
      get :list, params: { order_by: 'order_by_name' }
      expect(response).to have_http_status(200)
      expect(response).to render_template(partial: 'power_generators/partials/_list')
    end
  end

  describe "GET #calculate_freight" do
    power_generator = FactoryBot.create(:power_generator)
    cost = FactoryBot.create(:freight, weight_min: power_generator.weight - 20, weight_max: power_generator.weight + 10).cost

    expected = {value: ActionController::Base.helpers.number_to_currency(cost)}.to_json
    it "returns http success" do
      get :calculate_freight, params: { id: power_generator.id, uf: 'CE' }
      expect(response).to have_http_status(200)
      expect(response.body).to eq(expected)
    end
  end
end
