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

ActiveRecord::Schema[7.0].define(version: 2022_06_17_133709) do
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

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.string "currency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "stripe_customer_id"
    t.string "stripe_payment_intent"
    t.bigint "company_id"
    t.index ["company_id"], name: "index_clients_on_company_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "stripe_connect_acc"
    t.string "stripe_acc_id"
    t.index ["email"], name: "index_companies_on_email", unique: true
  end

  create_table "companies_connect_paypals", force: :cascade do |t|
    t.string "marchant_id"
    t.string "marchant_id_in_pp"
    t.string "account_status"
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_companies_connect_paypals_on_company_id"
  end

  create_table "company_employees", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_company_employees_on_company_id"
    t.index ["user_id"], name: "index_company_employees_on_user_id"
  end

  create_table "company_sales_targets", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.integer "target_cents", default: 0, null: false
    t.string "target_currency", default: "USD", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.datetime "date", precision: nil
    t.index ["company_id"], name: "index_company_sales_targets_on_company_id"
    t.index ["user_id"], name: "index_company_sales_targets_on_user_id"
  end

  create_table "currencies", force: :cascade do |t|
    t.string "iso_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invoices", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.bigint "company_id", null: false
    t.bigint "user_id", null: false
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "USD", null: false
    t.text "description"
    t.string "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0, null: false
    t.integer "discount_cents", default: 0, null: false
    t.string "discount_currency", default: "USD", null: false
    t.integer "tax_cents", default: 0, null: false
    t.string "tax_currency", default: "USD", null: false
    t.integer "total_cents", default: 0, null: false
    t.string "total_currency", default: "USD", null: false
    t.string "payment_link"
    t.json "items"
    t.boolean "accept_paypal", default: false
    t.boolean "accept_credit_card", default: false
    t.string "currency", default: "USD"
    t.string "sale_tax"
    t.string "note"
    t.string "invoice_num"
    t.boolean "trash", default: false
    t.index ["client_id"], name: "index_invoices_on_client_id"
    t.index ["company_id"], name: "index_invoices_on_company_id"
    t.index ["invoice_num"], name: "index_invoices_on_invoice_num", unique: true
    t.index ["user_id"], name: "index_invoices_on_user_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "description"
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "USD", null: false
    t.string "quantity"
    t.bigint "invoice_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invoice_id"], name: "index_items_on_invoice_id"
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.bigint "invoice_id", null: false
    t.bigint "company_id", null: false
    t.integer "status"
    t.string "stripe_charge_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "refunded_amount_cents", default: 0, null: false
    t.string "refunded_amount_currency", default: "USD", null: false
    t.string "stripe_payment_intent"
    t.string "paypal_order_id"
    t.integer "payment_marchant", default: 0, null: false
    t.string "pp_order_id"
    t.index ["client_id"], name: "index_payments_on_client_id"
    t.index ["company_id"], name: "index_payments_on_company_id"
    t.index ["invoice_id"], name: "index_payments_on_invoice_id"
  end

  create_table "reports", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "super_admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_super_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_super_admins_on_reset_password_token", unique: true
  end

  create_table "user_sales_targets", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "target_cents", default: 0, null: false
    t.string "target_currency", default: "USD", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id", null: false
    t.datetime "date", precision: nil
    t.string "description"
    t.index ["company_id"], name: "index_user_sales_targets_on_company_id"
    t.index ["user_id"], name: "index_user_sales_targets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "department"
    t.integer "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "clients", "companies"
  add_foreign_key "companies_connect_paypals", "companies"
  add_foreign_key "company_employees", "companies"
  add_foreign_key "company_employees", "users"
  add_foreign_key "company_sales_targets", "companies"
  add_foreign_key "company_sales_targets", "users"
  add_foreign_key "invoices", "clients"
  add_foreign_key "invoices", "companies"
  add_foreign_key "invoices", "users"
  add_foreign_key "items", "invoices"
  add_foreign_key "payments", "clients"
  add_foreign_key "payments", "companies"
  add_foreign_key "payments", "invoices"
  add_foreign_key "user_sales_targets", "companies"
  add_foreign_key "user_sales_targets", "users"
end
