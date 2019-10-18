class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_create :create_unique_id


  def create_unique_id
  	self.unique_id = SecureRandom.hex(10)
  	return true
  end
end
