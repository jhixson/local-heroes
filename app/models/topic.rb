class Topic < ActiveRecord::Base
  belongs_to :location
  belongs_to :user
  has_many :replies, :dependent => :destroy
  accepts_nested_attributes_for :replies, :allow_destroy => true
  validates_presence_of :slug
  before_validation :make_slug

  acts_as_voteable

  private
  def make_slug
    self.slug = self.title[0..250].parameterize
  end
end
