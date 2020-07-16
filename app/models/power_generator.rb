class PowerGenerator < ApplicationRecord
  after_create :calcule_cubed_weight

  SORT_BY = [
    ['Nome', :order_by_name],
    ['Menor Preço', :order_by_less_price],
    ['Maior Preço', :order_by_greater_price],
    ['Menor KWP', :order_by_less_kwp],
    ['Maior KWP', :order_by_greater_kwp],
  ]

  validates :name, :description, :image_url, :manufacturer, :price, :kwp, presence: true
  validates :height, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 40 }
  validates :width, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :lenght, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 200 }
  validates :weight, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 3000 }

  scope :order_by_name, -> { order(:name) }
  scope :order_by_less_price, -> { order(:price) }
  scope :order_by_greater_price, -> { order(price: :desc) }
  scope :order_by_less_kwp, -> { order(:kwp) }
  scope :order_by_greater_kwp, -> { order(kwp: :desc) }

  enum structure_type: %i[
    metalico
    ceramico
    fibrocimento
    laje
    solo
    trapezoidal
  ]

  private

  def calcule_cubed_weight
    cubed_weight = height * width * lenght * 300
    self.update(cubed_weight: cubed_weight)
  end
end
