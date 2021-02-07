class RemoveUserFromTags < ActiveRecord::Migration[6.0]
  def change
    remove_reference :tags, :user, null: false, foreign_key: true
  end
end
