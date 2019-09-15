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

ActiveRecord::Schema.define(version: 0) do

  create_table "musics", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin", force: :cascade do |t|
    t.string "title", null: false
    t.string "artist", null: false
  end

  create_table "preferences", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.float "note_speed"
    t.integer "se_volume"
    t.index ["user_id"], name: "index_preferences_on_user_id", unique: true
  end

  create_table "scores", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "music_id", null: false
    t.string "difficulty", null: false
    t.integer "points", null: false
    t.integer "played_times", default: 0, null: false
    t.index ["music_id"], name: "index_scores_on_music_id"
    t.index ["user_id", "music_id", "difficulty"], name: "index_scores_on_user_id_and_music_id_and_difficulty", unique: true
    t.index ["user_id"], name: "index_scores_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin", force: :cascade do |t|
    t.string "qrcode", null: false
    t.string "name", null: false
    t.index ["qrcode"], name: "index_users_on_qrcode", unique: true
  end

  add_foreign_key "preferences", "users"
  add_foreign_key "scores", "musics"
  add_foreign_key "scores", "users"
end
