class Product < ApplicationRecord
  has_and_belongs_to_many :categories 
  has_many :product_stocks 
  validates :name, presence: true
  validates :price, presence: true
end
