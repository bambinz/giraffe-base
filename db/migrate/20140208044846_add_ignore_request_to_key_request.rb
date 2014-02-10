class AddIgnoreRequestToKeyRequest < ActiveRecord::Migration
  def change
    add_column :key_requests, :ignored, :boolean
  end
end
