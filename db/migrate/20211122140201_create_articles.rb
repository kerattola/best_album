class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.references :artist, null: false, foreign_key: true
      t.references :album, null: false, foreign_key: true
      t.string :label
      t.integer :year
      t.string :reviewer
      t.string :review_date

      t.timestamps
    end
  end
end
