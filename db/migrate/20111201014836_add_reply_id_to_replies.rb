class AddReplyIdToReplies < ActiveRecord::Migration
  def change
    add_column :replies, :reply_id, :int
  end
end
