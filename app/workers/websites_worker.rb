class WebsitesWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'high'

  def perform(member_id)
    user = User.find_by_id(member_id) 
    url_response = HTTParty.get(user.website)
    if url_response.present?
      parsed_html = Nokogiri::HTML(url_response)
      data = parsed_html.css('h1, h2, h3').map(&:text).join(" ")
      user.update_attributes(site_data: data)
    end  
  end
end
