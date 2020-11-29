class UsersController < ApplicationController
	before_action :find_user, only: [:show]
	
	def index
		@users = User.includes(:friendships, :inverse_friends).all
	end

	def new
		@user = User.new
	end	

	def create
		@user = User.create(user_params)
		if @user.save
			flash[:alert] = 'Member created successfully'
			redirect_to @user
		else
			flash[:error] = @user.errors.full_messages.join(', ')
			render :new
		end	
	end
		
	private
	def user_params
		params.require(:user).permit(:name, :website)
	end	

	def find_user
		@user = User.includes(:friendships, :inverse_friends).find_by_id(params[:id])
		array_id = []
		array_id.push(@user.friendships.map{|friend| friend.friend_id})
		array_id.push(@user.inverse_friends.map{|friend| friend.id})
		array_id.push(params[:id])
		@users = User.where.not(id: array_id.flatten)
	end	
end