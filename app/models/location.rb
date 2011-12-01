class Location < ActiveRecord::Base
  has_many :topics
  validates_uniqueness_of :zip
  validates_presence_of :city, :slug
  before_validation :make_slug

  private
  def make_slug
    self.slug = self.city.parameterize
  end
end
