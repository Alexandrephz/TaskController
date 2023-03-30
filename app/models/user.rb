class User < ApplicationRecord
  rolify


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  devise :database_authenticatable, :authentication_keys => [:username]
  
  validates :email, uniqueness: true
  validates :username, uniqueness: true

  after_create :assign_role

  def assign_role
    if User.all.count == 1 
      User.first.add_role :admin
    end
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
end
