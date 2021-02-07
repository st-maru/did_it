class CreateCompletions < ActiveRecord::Migration[6.0]
  def change
    create_table :completions do |t|
      t.string :summary, null: false
      t.text :memo
      t.date :working_day, null: false
      t.time :start_time, null: false
      t.time :ending_time, null: false
      t.references :user, foreign_key: true
      t.references :task, foreign_key: true
      t.timestamps
    end
  end
end
