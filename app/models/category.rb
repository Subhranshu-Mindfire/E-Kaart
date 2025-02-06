class Category < ApplicationRecord
  has_many :categories_products, dependent: :destroy   
  has_many :products, through: :categories_products 
  validates :name, presence: true
end
