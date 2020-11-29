class User < ApplicationRecord

	has_many :friendships
	has_many :friends, :through => :friendships
	has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
	has_many :inverse_friends, :through => :inverse_friendships, :source => :user

	validates :name, presence: true, uniqueness: true
	validates :website, presence: true, uniqueness: true
	# after_create :create_short_url

	# def create_short_url
	# 	url = "https://firebasedynamiclinks.googleapis.com/v1/shortLinks?key=AAAASuCXUqw:APA91bGU4jI7YG_F6hACW1u4ybXUrXgOI22hujB1ddLaYSN1UqCdHdoV-xN8JcxkOKGdNwsJbsyUK0e3Emv7qpIdA2ZPhk1XL4lhGMNX3ZSju_b2kO0ZlAJI-YvSOJVHqsKo3P3tb_39"	
		
	# end	
end
