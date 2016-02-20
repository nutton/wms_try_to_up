# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20110906202829) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "allocation_strategies", force: :cascade do |t|
    t.string   "name",         limit: 25, null: false
    t.string   "code",         limit: 5,  null: false
    t.string   "description",  limit: 50
    t.integer  "warehouse_id",            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "allocation_strategy_lines", force: :cascade do |t|
    t.integer  "order_sequence",                     null: false
    t.integer  "allocation_zone_id",                 null: false
    t.string   "containerization_method", limit: 25, null: false
    t.string   "minimum_pick_uom",        limit: 25, null: false
    t.string   "containerization_level",  limit: 25, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "allocation_strategy_id",             null: false
  end

  create_table "allocation_strategy_rules", force: :cascade do |t|
    t.integer  "warehouse_id",           null: false
    t.integer  "order_sequence",         null: false
    t.integer  "order_type_id"
    t.integer  "product_category_id"
    t.integer  "product_subcategory_id"
    t.integer  "allocation_strategy_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "customer_id"
    t.integer  "customer_type_id"
    t.integer  "product_status_id"
  end

  create_table "allocation_zones", force: :cascade do |t|
    t.string   "code",         null: false
    t.string   "name",         null: false
    t.string   "description",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "warehouse_id"
  end

  create_table "assignment_details", force: :cascade do |t|
    t.integer  "assignment_id",                  null: false
    t.integer  "expected_product_id"
    t.integer  "actual_product_id"
    t.integer  "expected_quantity"
    t.integer  "actual_quantity"
    t.integer  "from_container_id"
    t.integer  "to_container_id"
    t.date     "start_time"
    t.date     "finish_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "start_location_type", limit: 25
    t.integer  "start_location_id"
    t.string   "end_location_type",   limit: 25
    t.integer  "end_location_id"
    t.integer  "wave_id"
  end

  create_table "assignment_types", force: :cascade do |t|
    t.string   "code",       limit: 5,  null: false
    t.string   "name",       limit: 25, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id",            null: false
  end

  create_table "assignments", force: :cascade do |t|
    t.integer  "user_id"
    t.date     "start_timestamp"
    t.date     "finish_timestamp"
    t.boolean  "released_flag",               default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",            limit: 50,                null: false
    t.string   "type",             limit: 25,                null: false
    t.integer  "priority"
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name",                    limit: 50,  null: false
    t.string   "address_1",                           null: false
    t.string   "address_2"
    t.string   "city",                    limit: 100
    t.string   "postal_code"
    t.integer  "country_id",                          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "logo_filename",           limit: 100
    t.integer  "default_quantity_uom_id"
    t.integer  "default_length_uom_id"
    t.integer  "default_weight_uom_id"
  end

  create_table "container_contents", force: :cascade do |t|
    t.integer  "container_id",                              null: false
    t.integer  "product_id",                                null: false
    t.integer  "lot_id",                                    null: false
    t.integer  "product_status_id"
    t.decimal  "quantity",          precision: 8, scale: 2, null: false
    t.integer  "receipt_line_id"
    t.integer  "order_line_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "container_types", force: :cascade do |t|
    t.decimal  "length",                    precision: 8, scale: 2, null: false
    t.decimal  "width",                     precision: 8, scale: 2, null: false
    t.decimal  "height",                    precision: 8, scale: 2, null: false
    t.decimal  "maximum_weight",            precision: 8, scale: 2, null: false
    t.string   "purpose",        limit: 10
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "containers", force: :cascade do |t|
    t.string   "lp",                      limit: 50,                         null: false
    t.integer  "container_location_id",                                      null: false
    t.string   "container_location_type",                                    null: false
    t.integer  "container_type_id"
    t.decimal  "length",                             precision: 8, scale: 2
    t.decimal  "width",                              precision: 8, scale: 2
    t.decimal  "height",                             precision: 8, scale: 2
    t.decimal  "max_weight",                         precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "receipt_id"
    t.integer  "parent_container_id"
    t.string   "state",                   limit: 50,                         null: false
  end

  create_table "countries", force: :cascade do |t|
    t.string   "name",                              null: false
    t.string   "iso_code",               limit: 3
    t.string   "language",               limit: 25
    t.integer  "telephone_country_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customer_types", force: :cascade do |t|
    t.integer  "company_id",             null: false
    t.string   "code",        limit: 5,  null: false
    t.string   "description", limit: 25
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", force: :cascade do |t|
    t.integer  "company_id",                   null: false
    t.string   "name",             limit: 100, null: false
    t.string   "address_1",        limit: 100
    t.string   "address_2",        limit: 100
    t.string   "city",             limit: 50
    t.string   "postal_code",      limit: 10
    t.string   "state",            limit: 50
    t.integer  "country_id"
    t.string   "telephone",        limit: 20
    t.string   "email",            limit: 50
    t.string   "code",             limit: 5
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "customer_type_id"
  end

  create_table "dock_doors", force: :cascade do |t|
    t.string   "name",         limit: 10, null: false
    t.string   "direction",    limit: 25, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "warehouse_id"
  end

  create_table "inventory_adjustment_types", force: :cascade do |t|
    t.string   "code",        limit: 10, null: false
    t.string   "name",        limit: 25, null: false
    t.string   "description", limit: 50
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inventory_adjustments", force: :cascade do |t|
    t.integer  "inventory_adjustment_type_id",                                    null: false
    t.string   "adjustment_type",              limit: 10,                         null: false
    t.decimal  "adjustment_quantity",                     precision: 8, scale: 2, null: false
    t.integer  "user_id",                                                         null: false
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "location_types", force: :cascade do |t|
    t.integer  "warehouse_id",                                          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "length",                        precision: 8, scale: 2, null: false
    t.decimal  "width",                         precision: 8, scale: 2, null: false
    t.decimal  "height",                        precision: 8, scale: 2, null: false
    t.integer  "maximum_containers"
    t.string   "code",               limit: 10,                         null: false
    t.string   "name",               limit: 25,                         null: false
    t.decimal  "maximum_weight",                precision: 8, scale: 2
    t.boolean  "zone",                                                  null: false
    t.boolean  "aisle",                                                 null: false
    t.boolean  "bay",                                                   null: false
    t.boolean  "level",                                                 null: false
    t.boolean  "position",                                              null: false
  end

  create_table "locations", force: :cascade do |t|
    t.integer  "warehouse_id",                                         null: false
    t.string   "zone"
    t.string   "aisle"
    t.string   "bay"
    t.string   "level"
    t.string   "position"
    t.string   "name",                                                 null: false
    t.integer  "pick_travel_sequence"
    t.integer  "storage_travel_sequence"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "alias",                    limit: 100
    t.integer  "location_type_id",                                     null: false
    t.boolean  "available_for_storage",                default: false, null: false
    t.boolean  "available_for_allocation",             default: false, null: false
    t.integer  "allocation_zone_id"
    t.integer  "storage_zone_id"
    t.boolean  "mix_products",                         default: false, null: false
    t.boolean  "collapse_containers",                  default: false, null: false
    t.boolean  "replenishable",                        default: false, null: false
  end

  create_table "lots", force: :cascade do |t|
    t.integer  "product_id",                   null: false
    t.date     "fifo_date",                    null: false
    t.integer  "product_status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",              limit: 25, null: false
  end

  create_table "order_lines", force: :cascade do |t|
    t.integer  "line_sequence_number",   null: false
    t.integer  "product_id",             null: false
    t.integer  "lot_id"
    t.integer  "product_status_id"
    t.integer  "quantity_ordered",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_id",               null: false
    t.integer  "wave_id"
    t.integer  "allocation_strategy_id"
  end

  create_table "order_types", force: :cascade do |t|
    t.string   "order_type",  limit: 25, null: false
    t.string   "description", limit: 50
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id",             null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string   "order_number"
    t.date     "ship_date"
    t.integer  "customer_id"
    t.date     "received_date"
    t.integer  "order_type_id"
    t.string   "ship_address_1"
    t.string   "ship_address_2"
    t.string   "ship_city"
    t.string   "ship_postal_code"
    t.string   "ship_state"
    t.integer  "ship_country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
    t.string   "state",            limit: 50, null: false
    t.integer  "warehouse_id",                null: false
    t.integer  "priority"
  end

  create_table "product_categories", force: :cascade do |t|
    t.string   "name",        limit: 25,  null: false
    t.string   "description", limit: 100, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
  end

  create_table "product_location_assignments", force: :cascade do |t|
    t.integer  "product_id",             null: false
    t.integer  "location_id",            null: false
    t.integer  "replenishment_at",       null: false
    t.integer  "maximum_quantity",       null: false
    t.integer  "warehouse_id",           null: false
    t.integer  "replenish_to",           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "allocation_strategy_id", null: false
  end

  create_table "product_packages", force: :cascade do |t|
    t.boolean  "logical_each"
    t.boolean  "logical_case"
    t.boolean  "logical_pallet"
    t.decimal  "length",         precision: 8, scale: 2,                 null: false
    t.decimal  "width",          precision: 8, scale: 2,                 null: false
    t.decimal  "height",         precision: 8, scale: 2,                 null: false
    t.integer  "quantity",                                               null: false
    t.boolean  "active",                                 default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "product_id"
    t.integer  "uom_id",                                                 null: false
    t.decimal  "weight",         precision: 8, scale: 2
  end

  create_table "product_statuses", force: :cascade do |t|
    t.string   "code",        limit: 5,                  null: false
    t.string   "description", limit: 50,                 null: false
    t.boolean  "allocatable",            default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id",                             null: false
  end

  create_table "product_subcategories", force: :cascade do |t|
    t.integer  "product_category_id",             null: false
    t.string   "name",                limit: 25,  null: false
    t.string   "description",         limit: 100, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
  end

  create_table "product_warehouse_setups", force: :cascade do |t|
    t.integer  "product_id",                         null: false
    t.integer  "warehouse_id",                       null: false
    t.integer  "product_status_id",                  null: false
    t.integer  "allocation_strategy_id"
    t.integer  "storage_strategy_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "stack_height"
    t.string   "lot_management_type",    limit: 100, null: false
  end

  create_table "products", force: :cascade do |t|
    t.integer  "company_id",                         null: false
    t.string   "name",                   limit: 100, null: false
    t.string   "description",            limit: 200
    t.integer  "supplier_id"
    t.string   "gtin_number"
    t.string   "upc_number"
    t.string   "image_filename",         limit: 100
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "barcode",                limit: 100
    t.string   "alias",                  limit: 100
    t.integer  "product_category_id"
    t.integer  "product_subcategory_id"
  end

  create_table "purchase_order_lines", force: :cascade do |t|
    t.integer  "line_number"
    t.integer  "purchase_order_id",            null: false
    t.integer  "product_id",                   null: false
    t.decimal  "quantity",                     null: false
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "product_status_id"
    t.string   "state",             limit: 20, null: false
  end

  create_table "purchase_order_types", force: :cascade do |t|
    t.string   "purchase_order_type", limit: 25, null: false
    t.string   "description",         limit: 50
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id",                     null: false
  end

  create_table "purchase_orders", force: :cascade do |t|
    t.integer  "supplier_id"
    t.date     "ship_date"
    t.integer  "company_id"
    t.string   "purchase_order_number"
    t.integer  "purchase_order_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",                  limit: 50, null: false
  end

  create_table "receipt_lines", force: :cascade do |t|
    t.integer  "receipt_id",                        null: false
    t.string   "lp",                     limit: 50, null: false
    t.integer  "product_id",                        null: false
    t.integer  "lot_id",                            null: false
    t.integer  "product_status_id"
    t.decimal  "quantity",                          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "dock_door_id"
    t.integer  "purchase_order_line_id"
    t.string   "state",                  limit: 50, null: false
    t.date     "received_at"
    t.integer  "received_by_user_id"
  end

  create_table "receipt_types", force: :cascade do |t|
    t.string   "name",        limit: 25,  null: false
    t.string   "code",        limit: 50,  null: false
    t.string   "description", limit: 100
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id",              null: false
  end

  create_table "receipts", force: :cascade do |t|
    t.integer  "supplier_id",                       null: false
    t.date     "estimated_receipt_date"
    t.integer  "receipt_type_id"
    t.integer  "warehouse_id",                      null: false
    t.string   "receipt_number",         limit: 50, null: false
    t.date     "ship_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "received_at"
    t.string   "state",                  limit: 50, null: false
  end

  create_table "shipment_contents", force: :cascade do |t|
    t.integer  "shipment_id",  null: false
    t.integer  "content_id"
    t.string   "content_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shipments", force: :cascade do |t|
    t.string   "shipment_number",            null: false
    t.date     "arrival_date"
    t.date     "departure_date"
    t.string   "direction",       limit: 25, null: false
    t.integer  "dock_door_id",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",           limit: 50, null: false
    t.integer  "warehouse_id",               null: false
  end

  create_table "storage_strategies", force: :cascade do |t|
    t.string   "code",         limit: 10,  null: false
    t.string   "name",         limit: 50,  null: false
    t.string   "description",  limit: 100
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "warehouse_id",             null: false
  end

  create_table "storage_strategy_lines", force: :cascade do |t|
    t.integer  "order_sequence",                      null: false
    t.integer  "storage_zone_id",                     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "check_volume",        default: false, null: false
    t.boolean  "check_dimensions",    default: false, null: false
    t.boolean  "check_containers",    default: false, null: false
    t.integer  "storage_strategy_id",                 null: false
  end

  create_table "storage_strategy_rules", force: :cascade do |t|
    t.integer  "warehouse_id",           null: false
    t.integer  "order_sequence_number",  null: false
    t.integer  "product_category_id"
    t.integer  "product_subcategory_id"
    t.integer  "uom_id"
    t.integer  "supplier_id"
    t.integer  "product_status_id"
    t.integer  "container_type_id"
    t.integer  "storage_strategy_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "purchase_order_type_id"
    t.integer  "receipt_type_id"
  end

  create_table "storage_zones", force: :cascade do |t|
    t.string   "code",         limit: 5, null: false
    t.string   "name",                   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "warehouse_id"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string   "name",        limit: 100, null: false
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "postal_code"
    t.integer  "country_id"
    t.string   "state"
    t.string   "telephone",   limit: 20,  null: false
    t.string   "email",       limit: 100, null: false
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
    t.string   "website",     limit: 100
  end

  create_table "system_parameters", force: :cascade do |t|
    t.string   "code",         limit: 3,   null: false
    t.string   "name",         limit: 50,  null: false
    t.string   "description",  limit: 100
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "warehouse_id"
    t.boolean  "value"
  end

  create_table "uoms", force: :cascade do |t|
    t.string   "code",        limit: 5,                  null: false
    t.string   "description", limit: 50
    t.string   "name",        limit: 25,                 null: false
    t.string   "type",        limit: 25
    t.boolean  "discrete",               default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",                 null: false
    t.string   "last_name",                  null: false
    t.string   "username",                   null: false
    t.string   "password_digest",            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "dob",                        null: false
    t.string   "email",           limit: 50, null: false
    t.string   "position",        limit: 50
    t.integer  "warehouse_id"
    t.string   "sex",             limit: 10, null: false
  end

  create_table "warehouses", force: :cascade do |t|
    t.string   "name",        limit: 100, null: false
    t.string   "description",             null: false
    t.string   "address_1",               null: false
    t.string   "address_2"
    t.string   "city",                    null: false
    t.string   "postal_code"
    t.integer  "country_id",              null: false
    t.string   "code",                    null: false
    t.integer  "company_id",              null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",       limit: 25
  end

  create_table "waves", force: :cascade do |t|
    t.string   "wave_number",        limit: 25, null: false
    t.datetime "started_running_at"
    t.datetime "stopped_running_at"
    t.string   "state",              limit: 25, null: false
    t.integer  "user_id",                       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "warehouse_id",                  null: false
  end

end
