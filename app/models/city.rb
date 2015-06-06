require 'nokogiri'

class City < ActiveRecord::Base

  has_many :transit_modes
  has_many :pics

  validates :name, :country, presence: true
  validates_uniqueness_of :name, scope: (:state ? [:country, :state] : :country)

  after_create :scrape_header_pic

  def scrape_header_pic
    uri = URI("http://www.bing.com/images/search?q=#{name.}&view=detail&first=1")
    response = Net::HTTP.get_response(uri)
    content = Nokogiri::HTML(response.body)
    string = content.search('.dg_u > a:first-child')[0]['m']
    header_url = string.gsub(/.*imgurl:\"(.*)\",ow.*/, '\1')
  end

end