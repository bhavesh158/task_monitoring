class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :details
      t.string :status
      t.integer :team_id
      t.integer :user_id

      t.timestamps
    end
  end
end
