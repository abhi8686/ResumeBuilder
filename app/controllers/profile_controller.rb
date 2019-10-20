class ProfileController < ApplicationController
	before_action :authenticate_user!
	
	def index
		@user = current_user
		@awards = @user.awards 
		@certifications = @user.certifications
		@educations = @user.educations
	end

	def update_profile_pic
		@user = current_user
		data = CommonImage.upload_from_file(params[:file], ProfileImage.versions, ProfileImage.name)
		@user.profile_image_id = data.id

		if @user.save
			render json: {},status: 200
		else
			render json: {}, status: 500
		end
	end

	def profile_info
		current_user.profile_info = params[:profile_info]
		if current_user.save
			render json: {msg: 'successfully updated'}, status: 200
		else
			render json: {errors: current_user.errors}, status: 500
		end
	end

	def get_modal
		obj_class = params[:entity].split('_')[0].classify.constantize
		@obj = params[:id] ? obj_class.find(params[:id]) : obj_class.new
		render partial: "#{params[:entity].split('_')[0]}_modal", status: 200	
	end

	def update
		@user = current_user
		data = @user.update_info(params)
		if data[:status]
			render json: data, status: 200
		else
			render json: data, status: 500
		end
	end

	def delete
		@user = current_user
		data = @user.delete_entity(params[:entity], params[:id])
	end

		
end
