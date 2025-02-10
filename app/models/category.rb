class Category < ApplicationRecord
  has_many :categories_products, dependent: :destroy   
  has_many :products, through: :categories_products
  belongs_to :parent, class_name: 'Category', optional: true
  has_many :subcategories, class_name: 'Category', foreign_key: 'parent_id'
  
  validates :name, presence: true
end
