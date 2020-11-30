class User < ApplicationRecord

	has_many :friendships
	has_many :friends, :through => :friendships
	has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
	has_many :inverse_friends, :through => :inverse_friendships, :source => :user

	validates :name, presence: true, uniqueness: true
	validates :website, presence: true, uniqueness: true
	after_create :create_short_url

	def create_short_url
		begin
			firebase_object = FirebaseDynamicLink.configure do |config|
	      # the adapter should be supported by Faraday
	      # more info look at https://github.com/lostisland/faraday/tree/master/test/adapters
	      # Faraday.default_adapter is the default adapter
	      config.adapter = :httpclient

	      # required
	      config.api_key = ENV['API_KEY']

	      # default 'UNGUESSABLE'
	      config.suffix_option = 'SHORT' or 'UNGUESSABLE'

	      # required
	      config.dynamic_link_domain = 'https://challenge7.page.link'

	      # default 3 seconds
	      config.timeout = 3 

	      # default 3 seconds
	      config.open_timeout = 3
	    end

	    client = ll::Client.new
	    link = self.website
	    options = {
	      # optional, to override default dynamic_link_domain default config
	      dynamic_link_domain: 'https://challenge7.page.link', 

	      # optional, timeout of each request of this instance
	      timeout: 10, 

	      # optional, open timeout of each request of this instance
	      open_timeout: 10
	    }

	    # options argument is optional
	    result = client.shorten_link(link, options)
	    self.short_website = result[:link]
	    self.save
	  rescue Exception => e
	  	Rails.logger.info("exception occur while creating short url #{e}")
	  end  
	end	

end
