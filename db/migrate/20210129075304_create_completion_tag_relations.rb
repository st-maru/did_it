class CreateCompletionTagRelations < ActiveRecord::Migration[6.0]
  def change
    create_table :completion_tag_relations do |t|
      t.references :completion, foreign_key: true
      t.references :tag, foreign_key: true
      t.timestamps
    end
  end
end
