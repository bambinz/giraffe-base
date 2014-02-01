class CreateKeyRequests < ActiveRecord::Migration
  def change
    create_table :key_requests do |t|
      t.integer :user_id
      t.integer :to_user_id
      t.string :key
      t.datetime :expire_date
      t.datetime :accepted_date
      t.boolean :accepted, default: false
      t.integer :key_request_type
      t.timestamps
    end
  end
end
