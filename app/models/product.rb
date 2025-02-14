class Product < ApplicationRecord
  has_many :categories_products, dependent: :destroy
  has_many :categories, through: :categories_products
  has_many_attached :images
  has_many :product_stocks 
  has_many :orders
  has_many :cart_items
  belongs_to :user
  validates :name, presence: true
  validates :price, presence: true

end
