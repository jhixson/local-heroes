class Reply < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user
  has_and_belongs_to_many :replies,
                          :join_table => 'replies_to_replies',
                          :foreign_key => 'reply_to_reply_id',
                          :association_foreign_key => 'reply_id',
                          :after_add => :create_reverse_association,
                          :after_remove => :remove_reverse_association

  acts_as_voteable

  before_save :set_user

  private
    def set_user
      @current_user_session = UserSession.find
      @current_user = @current_user_session.user
      self.user_id = @current_user.id if self.user_id.blank?
    end
end
