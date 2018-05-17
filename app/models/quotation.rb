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
#  paid             :boolean
#

class Quotation < ApplicationRecord

  validates :event_date,      presence: true
  validates :event_time,      presence: true
  validates :pickup_time,     presence: true
  validates :pickup_date,     presence: true
  validates :name,            presence: true
  validates :company,         presence: true
  validates :address,         presence: true
  validates :phone,           presence: true

  after_create :set_initial_status

  has_many :products

  scope :pending,     -> { where(status: 'pendiente') }
  scope :completed,   -> { where(status: 'completada') }
  scope :cancelled,   -> { where(status: 'cancelada') }
  scope :paid,        -> { where(paid: true) }
  scope :not_paid,    -> { where(paid: false) }

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
    self.paid   = 'no'
    save
  end

end
