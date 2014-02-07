class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.integer :user_id
      t.boolean :show_in_search
      t.boolean :accept_friend_reqests
      t.boolean :public_profile
      t.text :public_attributes

      t.timestamps
    end
  end
end
