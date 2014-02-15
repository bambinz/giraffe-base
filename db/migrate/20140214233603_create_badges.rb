class CreateBadges < ActiveRecord::Migration
  def change
    create_table :badges do |t|
      t.string :name
      t.string :description
      t.integer :level
      t.integer :badge_type
      t.integer :stage
      
      t.timestamps
    end
  end
end
