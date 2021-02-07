class CreateThanks < ActiveRecord::Migration[6.0]
  def change
    create_table :thanks do |t|
      t.string :human, null: false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
