class Quotation < ApplicationRecord

  validates :date, presence: true
  validates :name, presence: true
  validates :company, presence: true
  validates :address, presence: true
  validates :phone, presence: true

  after_create :set_initial_state

  scope :pending, -> { where(status: 'pendiente') }
  scope :cancelled, -> { where(status: 'cancelada') }
  scope :closed, -> { where(status: 'cerrada') }

  private

  def set_initial_state
    self.status = 'pendiente'
    save!
  end

end
