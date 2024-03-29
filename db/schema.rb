# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_03_13_175735) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "bill_services", force: :cascade do |t|
    t.bigint "bill_id", null: false
    t.bigint "service_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "rate"
    t.float "days_worked"
    t.string "currency"
    t.index ["bill_id"], name: "index_bill_services_on_bill_id"
    t.index ["service_id"], name: "index_bill_services_on_service_id"
  end

  create_table "bills", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "client_id", null: false
    t.date "bill_date"
    t.float "amount"
    t.text "description"
    t.float "days_worked"
    t.float "rate"
    t.text "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_email"
    t.string "user_fullname"
    t.string "user_business_name"
    t.string "user_street"
    t.string "user_city"
    t.string "user_bank_name"
    t.string "user_iban"
    t.string "user_bic"
    t.string "user_account_number"
    t.string "user_phone_number"
    t.integer "customer_bill_number"
    t.integer "user_bill_number"
    t.string "client_name"
    t.string "client_address"
    t.string "client_phone"
    t.string "client_email"
    t.string "client_city"
    t.string "contact_name"
    t.string "cc"
    t.string "subject"
    t.string "currency"
    t.index ["client_id"], name: "index_bills_on_client_id"
    t.index ["user_id"], name: "index_bills_on_user_id"
  end

  create_table "clients", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "client_address"
    t.string "client_email"
    t.string "client_phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "client_name"
    t.string "contact_name"
    t.string "client_city"
    t.datetime "deleted_at"
    t.integer "client_number"
    t.integer "total_bills_created", default: 0
    t.index ["deleted_at"], name: "index_clients_on_deleted_at"
    t.index ["user_id"], name: "index_clients_on_user_id"
  end

  create_table "plans", force: :cascade do |t|
    t.string "title"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "price_cents", default: 0, null: false
  end

  create_table "services", force: :cascade do |t|
    t.text "description"
    t.float "rate"
    t.float "days_worked"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.datetime "deleted_at"
    t.integer "service_number"
    t.string "currency"
    t.index ["deleted_at"], name: "index_services_on_deleted_at"
    t.index ["user_id"], name: "index_services_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "fullname"
    t.string "business_name"
    t.string "street"
    t.string "city"
    t.string "bank_name"
    t.string "iban"
    t.string "bic"
    t.string "account_number"
    t.string "phone_number"
    t.string "provider"
    t.string "uid"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bill_services", "bills"
  add_foreign_key "bill_services", "services"
  add_foreign_key "bills", "clients"
  add_foreign_key "bills", "users"
  add_foreign_key "clients", "users"
  add_foreign_key "services", "users"
end
