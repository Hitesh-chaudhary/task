module UsersHelper
	def count_friend(user)
		user.friendships.length + user.inverse_friends.length
	end	
end
