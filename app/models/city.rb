
class City < ActiveRecord::Base

  has_many :transit_modes
  has_many :pics

  validates :name, :country, presence: true
  validates_uniqueness_of :name, scope: (:state ? [:country, :state] : :country)

  after_create :scrape_header_pic

  def scrape_header_pic
    list   = flickr.photos.search(text: name+" transit",sort: "relevance", content_type: '1', page: '1', per_page: '2')
    id     = list[0].id
    secret = list[0].secret
    info = flickr.photos.getInfo :photo_id => id, :secret => secret
    update_attributes(header: FlickRaw.url_b(info))
  end

end