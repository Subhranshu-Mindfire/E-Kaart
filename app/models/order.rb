class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product

  enum order_status: {
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