class Experience < ApplicationRecord
	#associations
	belongs_to :user
	has_many :projects


	def self.save_profile parameters, user_id
		if self.new.attributes.keys.to_set - parameters["experiences"].keys.to_set
			obj = self.where(id: parameters["experiences"]["id"]).first || self.new
			parameters["experiences"].keys.each do |x|
				obj.send("#{x}=", parameters["experiences"][x])
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
