class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :artist
      t.string :album
      t.string :label
      t.integer :year
      t.string :reviewer
      t.text :review_date
      t.float :score

      t.timestamps
    end
  end
end
