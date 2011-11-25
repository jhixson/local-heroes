class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.change_single_access_token_with_password = true
  end
  acts_as_voter
  has_karma(:topics, :as => :submitter, :weight => 0.5)
end
