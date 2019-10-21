class Project < ApplicationRecord

	#associations
	belongs_to :experience


	def self.save_profile parameters, user_id
		if self.new.attributes.keys.to_set - parameters["projects"].keys.to_set
			obj = self.where(id: parameters["projects"]["id"]).first || self.new
			parameters["projects"].keys.each do |x|
				obj.send("#{x}=", parameters["projects"][x])
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
