class CreateCourses < ActiveRecord::Migration[7.1]
  def change
    create_table :courses do |t|
      t.string  :title, null: false
      t.text    :description
      t.integer :capacity
      t.integer :price_cents
      t.boolean :published, null: false, default: false

      # KLUCZOWA LINIA ↓  (FK do users, nie do instructors)
      t.references :instructor, null: false, foreign_key: { to_table: :users }, index: true

      t.timestamps
    end
  end
end
