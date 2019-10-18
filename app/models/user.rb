class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_create :create_unique_id

  has_many :highlights, dependent: :destroy

  def create_unique_id
  	self.unique_id = SecureRandom.hex(10)
  	return true
  end

    @@versions = {
      :profile_square => [300, 300]
  }

  def self.versions
    @@versions
  end
end
