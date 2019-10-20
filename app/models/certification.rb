class Certification < ApplicationRecord

		#associations
	belongs_to :user

	#validations
	validates_presence_of :institute_name, :name, :start_date, :end_date, :institute_name, :location


	def self.save_profile parameters, user_id
		if self.new.attributes.keys.to_set - parameters["certifications"].keys.to_set
			obj = self.where(id: parameters["certifications"]["id"]).first || self.new
			parameters["certifications"].keys.each do |x|
				obj.send("#{x}=", parameters["certifications"][x])
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
