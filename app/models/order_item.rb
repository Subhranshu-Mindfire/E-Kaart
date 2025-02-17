class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  validates :quantity, numericality: true

  enum status: {
    placed: 0,
    accepted: 1,
    shipped: 2,
    delivered: 3,
    canceled: 4 
  }

  enum payment_status: {
    success: 0,
    failed: 1
  }
end
