class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer  :user_id
      t.text     :content
      t.integer  :notification_type
      t.boolean  :seen
      t.integer  :priority
      t.boolean  :read
      
      t.timestamps
    end
  end
end


