class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles
  has_many :products

  validates :email, presence: true, uniqueness: true 
        
  enum status: {
    active: 0,
    inactive: 1
  }
  def admin?
    role_ids.include?(1)
  end

  def owner?
    role_ids.include?(3)
  end

end
