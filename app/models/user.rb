class User < ActiveRecord::Base
  has_many :topics
  has_many :replies
  acts_as_authentic do |c|
    c.change_single_access_token_with_password = true
  end
end
