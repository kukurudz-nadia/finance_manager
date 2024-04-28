ActiveRecord::Schema[7.0].define(version: 2023_02_16_215809) do
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.decimal "amount"
    t.datetime "odate"
    t.string "description"
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "kind"
    t.index ["category_id"], name: "index_transactions_on_category_id"
  end

  add_foreign_key "transactions", "categories"
end

