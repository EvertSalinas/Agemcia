class Product < ApplicationRecord

  validates :amount, presence: true
  validates :concept, presence: true
  validates :price, presence: true

  monetize :price_cents

  def calculate_total
    Money.new(price * amount, 'MXN')
  end

end
