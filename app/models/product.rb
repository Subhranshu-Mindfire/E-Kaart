class Product < ApplicationRecord
  has_many :categories_products
  has_many :categories, through: :categories_products 
  validates :name, presence: true
  validates :price, presence: true
end
