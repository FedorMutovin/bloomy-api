class AddActivatedAtToWishes < ActiveRecord::Migration[7.2]
  def change
    add_column :wishes, :activated_at, :datetime
  end
end
