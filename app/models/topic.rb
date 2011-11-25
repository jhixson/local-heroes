class Topic < ActiveRecord::Base
  belongs_to :user
  has_many :replies, :dependent => :destroy
  accepts_nested_attributes_for :replies, :allow_destroy => true
  acts_as_voteable
end
