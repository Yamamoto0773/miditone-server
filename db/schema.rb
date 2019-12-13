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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "preferences", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.float "note_speed"
    t.integer "se_volume"
    t.string "platform", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "platform"], name: "index_preferences_on_user_id_and_platform", unique: true
    t.index ["user_id"], name: "index_preferences_on_user_id"
  end

  create_table "scores", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "music_id", null: false
    t.string "difficulty", null: false
    t.integer "points", null: false
    t.integer "max_combo", null: false
    t.integer "critical_count", null: false
    t.integer "correct_count", null: false
    t.integer "nice_count", null: false
    t.integer "miss_count", null: false
    t.integer "played_times", default: 0, null: false
    t.string "platform", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_scores_on_created_at"
    t.index ["music_id"], name: "index_scores_on_music_id"
    t.index ["user_id", "music_id", "difficulty", "platform"], name: "index_scores_on_user_id_and_music_id_and_difficulty_and_platform", unique: true
    t.index ["user_id"], name: "index_scores_on_user_id"
  end

  create_table "tokens", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin", force: :cascade do |t|
    t.string "name", null: false
    t.string "digest_hash", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["digest_hash"], name: "index_tokens_on_digest_hash", unique: true
    t.index ["name"], name: "index_tokens_on_name", unique: true
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin", force: :cascade do |t|
    t.string "qrcode", null: false
    t.string "name", null: false
    t.integer "button_total_score", default: 0, null: false
    t.integer "board_total_score", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_users_on_created_at"
    t.index ["qrcode"], name: "index_users_on_qrcode", unique: true
  end

  add_foreign_key "preferences", "users"
  add_foreign_key "scores", "musics"
  add_foreign_key "scores", "users"
end
