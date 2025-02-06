class Product < ApplicationRecord
  has_many :categories_products, dependent: :destroy
  has_many :categories, through: :categories_products 
  belongs_to :user
  validates :name, presence: true
  validates :price, presence: true
end
