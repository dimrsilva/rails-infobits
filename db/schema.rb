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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130304052916) do

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.index ["email"], :name => "index_admin_users_on_email", :unique => true
    t.index ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true
  end

  create_table "contact_people", :force => true do |t|
    t.string "prefix"
    t.string "firstname"
    t.string "middlename"
    t.string "lastname"
    t.string "doc_cpf"
    t.string "doc_rg"
  end

  create_table "contact_companies", :force => true do |t|
    t.string  "fantasy_name"
    t.string  "legal_name"
    t.string  "doc_cnpj"
    t.string  "doc_ie"
    t.string  "doc_im"
    t.integer "contact_person_id"
    t.index ["contact_person_id"], :name => "fk__contact_companies_contact_person_id"
    t.foreign_key ["contact_person_id"], "contact_people", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_contact_companies_contact_person_id"
  end

  create_table "contact_contacts", :force => true do |t|
    t.string   "type"
    t.string   "fullname"
    t.date     "birthdate"
    t.text     "note"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "contact_property_addresses", :force => true do |t|
    t.string "street"
    t.string "neighborhood"
    t.string "postal_code"
    t.string "city"
    t.string "state"
    t.string "country"
  end

  create_table "contact_property_properties", :force => true do |t|
    t.string   "type"
    t.string   "label"
    t.string   "value"
    t.integer  "contact_contact_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.index ["contact_contact_id"], :name => "fk__contact_property_properties_contact_contact_id"
    t.foreign_key ["contact_contact_id"], "contact_contacts", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_contact_property_properties_contact_contact_id"
  end

  create_view "view_contact_companies", "select `contact_contacts`.`id` AS `id`,`contact_contacts`.`type` AS `type`,`contact_contacts`.`fullname` AS `fullname`,`contact_contacts`.`birthdate` AS `birthdate`,`contact_contacts`.`note` AS `note`,`contact_contacts`.`created_at` AS `created_at`,`contact_contacts`.`updated_at` AS `updated_at`,`contact_companies`.`fantasy_name` AS `fantasy_name`,`contact_companies`.`legal_name` AS `legal_name`,`contact_companies`.`doc_cnpj` AS `doc_cnpj`,`contact_companies`.`doc_ie` AS `doc_ie`,`contact_companies`.`doc_im` AS `doc_im`,`contact_companies`.`contact_person_id` AS `contact_person_id` from `contact_contacts` join `contact_companies` where (`contact_contacts`.`id` = `contact_companies`.`id`)", :force => true
  create_view "view_contact_people", "select `contact_contacts`.`id` AS `id`,`contact_contacts`.`type` AS `type`,`contact_contacts`.`fullname` AS `fullname`,`contact_contacts`.`birthdate` AS `birthdate`,`contact_contacts`.`note` AS `note`,`contact_contacts`.`created_at` AS `created_at`,`contact_contacts`.`updated_at` AS `updated_at`,`contact_people`.`prefix` AS `prefix`,`contact_people`.`firstname` AS `firstname`,`contact_people`.`middlename` AS `middlename`,`contact_people`.`lastname` AS `lastname`,`contact_people`.`doc_cpf` AS `doc_cpf`,`contact_people`.`doc_rg` AS `doc_rg` from `contact_contacts` join `contact_people` where (`contact_contacts`.`id` = `contact_people`.`id`)", :force => true
  create_view "view_contact_property_addresses", "select `contact_property_properties`.`id` AS `id`,`contact_property_properties`.`type` AS `type`,`contact_property_properties`.`label` AS `label`,`contact_property_properties`.`value` AS `value`,`contact_property_properties`.`contact_contact_id` AS `contact_contact_id`,`contact_property_properties`.`created_at` AS `created_at`,`contact_property_properties`.`updated_at` AS `updated_at`,`contact_property_addresses`.`street` AS `street`,`contact_property_addresses`.`neighborhood` AS `neighborhood`,`contact_property_addresses`.`postal_code` AS `postal_code`,`contact_property_addresses`.`city` AS `city`,`contact_property_addresses`.`state` AS `state`,`contact_property_addresses`.`country` AS `country` from `contact_property_properties` join `contact_property_addresses` where (`contact_property_properties`.`id` = `contact_property_addresses`.`id`)", :force => true
end
