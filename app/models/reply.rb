class Reply < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user
  acts_as_voteable

  before_save :set_user

  private
    def set_user
      @current_user_session = UserSession.find
      @current_user = @current_user_session.user
      self.user_id = @current_user.id if self.user_id.blank?
    end
end
