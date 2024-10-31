class AddEngagementLevel < ActiveRecord::Migration[7.2]
  def change
    add_column :hobbies, :engagement_level, :integer, default: 0
    add_column :interests, :engagement_level, :integer, default: 0
  end
end
