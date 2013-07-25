class AddAttachmentCommentAttachmentToTaskComments < ActiveRecord::Migration
  def self.up
    change_table :task_comments do |t|
      t.attachment :comment_attachment
    end
  end

  def self.down
    drop_attached_file :task_comments, :comment_attachment
  end
end
