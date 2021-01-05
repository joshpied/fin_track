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

ActiveRecord::Schema.define(version: 2020_12_10_232258) do

  create_table "budgets", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.decimal "amount", precision: 13, scale: 2, null: false
    t.boolean "active"
    t.bigint "user_id", null: false
    t.bigint "report_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["report_id"], name: "index_budgets_on_report_id"
    t.index ["user_id"], name: "index_budgets_on_user_id"
  end

  create_table "reports", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.decimal "total_amount", precision: 13, scale: 2, default: "0.0", null: false
    t.datetime "report_date", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.integer "month"
    t.integer "year"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "month", "year"], name: "index_reports_on_user_id_and_month_and_year"
    t.index ["user_id"], name: "index_reports_on_user_id"
  end

  create_table "transaction_categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "transactions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.text "note"
    t.decimal "amount", precision: 13, scale: 2, null: false
    t.datetime "transaction_date", null: false
    t.bigint "user_id", null: false
    t.bigint "transaction_category_id", null: false
    t.bigint "report_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["report_id"], name: "index_transactions_on_report_id"
    t.index ["transaction_category_id"], name: "index_transactions_on_transaction_category_id"
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", null: false
    t.string "encrypted_password", limit: 128, null: false
    t.string "confirmation_token", limit: 128
    t.string "remember_token", limit: 128, null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["remember_token"], name: "index_users_on_remember_token"
  end

  add_foreign_key "budgets", "reports"
  add_foreign_key "budgets", "users"
  add_foreign_key "reports", "users"
  add_foreign_key "transactions", "reports"
  add_foreign_key "transactions", "transaction_categories"
  add_foreign_key "transactions", "users"
end
