class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_create :create_unique_id

  #assoications
  has_many :highlights, dependent: :destroy
  has_many :awards, dependent: :destroy
  has_many :certifications, dependent: :destroy
  has_many :educations, dependent: :destroy

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

  def update_info parameters
    ["controller", "action"].map{|x| parameters.delete(x)}
    parameters.keys.each do |x|
      # return {status: false} if User.allowed_methods.include? x
      return x.classify.constantize.send('save_profile', parameters, self.id)
    end
  end

  def self.allowed_methods
    "awards,certifications".split(',')    
  end

  def delete_entity entity, id
    obj_class = entity.classify.constantize
    obj = obj_class.find(id)
    if obj.user_id = self.id
      obj.destroy
    end
  end
end
