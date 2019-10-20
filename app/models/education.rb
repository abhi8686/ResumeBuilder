class Education < ApplicationRecord


	def self.save_profile parameters, user_id
		if self.new.attributes.keys.to_set - parameters["educations"].keys.to_set
			obj = self.where(id: parameters["educations"]["id"]).first || self.new
			parameters["educations"].keys.each do |x|
				obj.send("#{x}=", parameters["educations"][x])
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
