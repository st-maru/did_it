class RemoveItemFromTags < ActiveRecord::Migration[6.0]
  def change
    remove_column :tags, :item, :text
  end
end
