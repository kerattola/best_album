# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_11_22_140201) do

  create_table "albums", force: :cascade do |t|
    t.string "title"
    t.integer "score_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["score_id"], name: "index_albums_on_score_id"
  end

  create_table "articles", force: :cascade do |t|
    t.integer "artist_id", null: false
    t.integer "album_id", null: false
    t.string "label"
    t.integer "year"
    t.string "reviewer"
    t.string "review_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["album_id"], name: "index_articles_on_album_id"
    t.index ["artist_id"], name: "index_articles_on_artist_id"
  end

  create_table "artists", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "scores", force: :cascade do |t|
    t.float "number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "albums", "scores"
  add_foreign_key "articles", "albums"
  add_foreign_key "articles", "artists"
end
