# == Schema Information
#
# Table name: quotations
#
#  id               :bigint(8)        not null, primary key
#  event_date       :date
#  name             :string
#  company          :string
#  address          :string
#  phone            :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  event_time       :datetime
#  pickup_time      :datetime
#  pickup_date      :date
#  elaboration_date :date
#  paid             :string
#  state            :string
#  deliver_date     :date
#  deliver_time     :date
#

class Quotation < ApplicationRecord
  include AASM

  validates :event_date,          presence: true
  validates :event_time,          presence: true
  validates :pickup_time,         presence: true
  validates :pickup_date,         presence: true
  validates :name,                presence: true
  validates :company,             presence: true
  validates :address,             presence: true
  validates :phone,               presence: true
  validates :deliver_date,        presence: true
  validates :deliver_time,        presence: true
  validates :elaboration_date,    presence: true

  after_create  :set_initial_paid_status

  has_many :products

  aasm column: 'state' do
    state :pendiente,   initial: true
    state :completada, :cancelada

    event :completar do
      transitions from: :pendiente, to: :completada
    end

    event :reactivar do
      transitions from: :cancelada, to: :pendiente
    end

    event :cancelar do
      transitions from: :pendiente, to: :cancelada
    end
  end

  scope :paid,        -> { where(paid: "si") }
  scope :not_paid,    -> { where(paid: "no") }

  def calculate_products_total
    total = 0
    products.each do |p|
      total += p.calculate_total
    end
    total
  end

  def pagada?
    paid == 'si'
  end

  def no_pagada?
    !pagada?
  end

  private

  def set_initial_paid_status
    self.update(paid: 'no')
  end

end
