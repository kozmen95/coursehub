class AddTitleAndDateToLessons < ActiveRecord::Migration[8.0]
  def change
    add_column :lessons, :title, :string
    add_column :lessons, :date, :datetime
  end
end
