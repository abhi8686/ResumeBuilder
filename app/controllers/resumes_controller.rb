class ResumesController < ApplicationController
  def show
  	@user = User.where(unique_id: params[:id]).first
		@awards = @user.awards 
		@certifications = @user.certifications
		@educations = @user.educations
  end
end
