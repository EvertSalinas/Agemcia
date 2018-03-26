class Product < ApplicationRecord

  monetize :price_cents

  def calculate_total
    Money.new(price * amount, 'MXN')
  end

end
