class ProfileController < ApplicationController

	def index
		@user = current_user
	end

	def create
		CommonImage.upload_from_file(params[:file], User.versions, User.name)
	end

end
