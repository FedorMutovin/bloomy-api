class AddUserReferences < ActiveRecord::Migration[7.2]
  def change
    add_reference :hobbies, :user, foreign_key: true, type: :uuid
    add_reference :actions, :user, foreign_key: true, type: :uuid
    add_reference :decisions, :user, foreign_key: true, type: :uuid
  end
end
