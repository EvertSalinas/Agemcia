# == Schema Information
#
# Table name: products
#
#  id             :bigint(8)        not null, primary key
#  concept        :string
#  amount         :integer
#  price_cents    :integer          default(0), not null
#  price_currency :string           default("USD"), not null
#  quotation_id   :bigint(8)
#

class Product < ApplicationRecord

  validates :amount, presence: true
  validates :concept, presence: true
  validates :price, presence: true

  monetize :price_cents

  def calculate_total
    Money.new(price * amount, 'MXN')
  end

end
