class PowerGeneratorsController < ApplicationController
  before_action :set_power_generator, only: [:show, :calculate_freight]
  def index;end

  def show
    render layout: false
  end

  def calculate_freight
    power_generator = PowerGenerator.find(params[:id])
    weight_value = power_generator.weight < power_generator.cubed_weight ? power_generator.weight : power_generator.cubed_weight
    value = Freight.where(state: params[:uf]).where('weight_min <= ? AND weight_max >= ?', weight_value, weight_value).first.cost
    render json: { value: view_context.number_to_currency(value)  }
  end

  def list
    @power_generators = PowerGenerator.send(params[:order_by]).ransack(params[:q]).result.page(params[:page]).per(6)
    respond_to do |format|
      format.html {
        render partial: 'power_generators/partials/list', locals: {power_generators: @power_generators}
      }
      format.js { render 'index.js.erb' }
    end
  end

  private

  def set_power_generator
    @power_generator = PowerGenerator.find(params[:id])
  end
end
