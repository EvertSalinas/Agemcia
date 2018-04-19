# == Schema Information
#
# Table name: quotations
#
#  id               :integer          not null, primary key
#  event_date       :date
#  name             :string
#  company          :string
#  address          :string
#  phone            :string
#  status           :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  event_time       :datetime
#  pickup_time      :datetime
#  pickup_date      :date
#  elaboration_date :date
#

class Quotation < ApplicationRecord

  validates :event_date, presence: true
  validates :name, presence: true
  validates :company, presence: true
  validates :address, presence: true
  validates :phone, presence: true

  after_create :set_initial_state

  has_many :products

  scope :pending, -> { where(status: 'pendiente') }
  scope :cancelled, -> { where(status: 'cancelada') }
  scope :closed, -> { where(status: 'cerrada') }

  def calculate_products_total
    total = 0
    products.each do |p|
      total += p.calculate_total
    end
    total
  end

  private

  def set_initial_state
    self.status = 'pendiente'
    save!
  end

end
