class ProductStock < ApplicationRecord
  belongs_to :product 
  validates :quantity, presence: true

  enum transaction_type: {
    in: 1,
    out: 0,
  }
end
