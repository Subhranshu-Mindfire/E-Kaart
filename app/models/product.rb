class Product < ApplicationRecord
  has_many :categories_products, dependent: :destroy
  has_many :categories, through: :categories_products
  has_many_attached :images
  has_many :product_stocks 
  belongs_to :user
  belongs_to :cart_item
  validates :name, presence: true
  validates :price, presence: true

end
