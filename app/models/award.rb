class Award < ApplicationRecord
	#associations
	belongs_to :user

	#validations
	validates_presence_of :institute_name, :award_name, :award_date


	def self.save_profile parameters, user_id
		if self.new.attributes.keys.to_set - parameters["awards"].keys.to_set
			obj = self.where(id: parameters["awards"]["id"]).first || self.new
			parameters["awards"].keys.each do |x|
				obj.send("#{x}=", parameters["awards"][x])
			end
			obj.user_id = user_id
			if obj.save
				{status: true, msg: "sucessfully created"} 
			else
				{status: false, errors: obj.errors}
			end
		else
			 {status: false, errors: "Invalid paramters"}
		end
	end
end
