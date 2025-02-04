class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles
        
  def admin?
    role_ids.include?(1)
  end

end
