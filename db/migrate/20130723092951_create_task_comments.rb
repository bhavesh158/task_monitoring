class CreateTaskComments < ActiveRecord::Migration
  def change
    create_table :task_comments do |t|
      t.text :message
      t.integer :task_id
      t.integer :user_id

      t.timestamps
    end
  end
end
