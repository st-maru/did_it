class CreateCompletionThankRelations < ActiveRecord::Migration[6.0]
  def change
    create_table :completion_thank_relations do |t|
      t.references :completion, foreign_key: true
      t.references :thank, foreign_key: true
      t.timestamps
    end
  end
end
