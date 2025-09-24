class CreateLessons < ActiveRecord::Migration[8.0]
  def change
    create_table :lessons do |t|
      t.references :course, null: false, foreign_key: true
      t.datetime :starts_at
      t.datetime :ends_at
      t.string :location

      t.timestamps
    end
  end
end
