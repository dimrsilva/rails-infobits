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

ActiveRecord::Schema.define(:version => 20130301004429) do

  create_table "contact_companies", :force => true do |t|
    t.string "fantasy_name"
    t.string "legal_name"
    t.string "doc_cnpj"
    t.string "doc_ie"
    t.string "doc_im"
  end

  create_table "contact_contacts", :force => true do |t|
    t.string   "type"
    t.string   "fullname"
    t.date     "birthdate"
    t.text     "note"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "contact_people", :force => true do |t|
    t.string "prefix"
    t.string "firstname"
    t.string "middlename"
    t.string "lastname"
    t.string "doc_cpf"
    t.string "doc_rg"
  end

  create_view "view_contact_companies", "select `contact_contacts`.`id` AS `id`,`contact_contacts`.`type` AS `type`,`contact_contacts`.`fullname` AS `fullname`,`contact_contacts`.`birthdate` AS `birthdate`,`contact_contacts`.`note` AS `note`,`contact_contacts`.`created_at` AS `created_at`,`contact_contacts`.`updated_at` AS `updated_at`,`contact_companies`.`fantasy_name` AS `fantasy_name`,`contact_companies`.`legal_name` AS `legal_name`,`contact_companies`.`doc_cnpj` AS `doc_cnpj`,`contact_companies`.`doc_ie` AS `doc_ie`,`contact_companies`.`doc_im` AS `doc_im` from `contact_contacts` join `contact_companies` where (`contact_contacts`.`id` = `contact_companies`.`id`)", :force => true
  create_view "view_contact_people", "select `contact_contacts`.`id` AS `id`,`contact_contacts`.`type` AS `type`,`contact_contacts`.`fullname` AS `fullname`,`contact_contacts`.`birthdate` AS `birthdate`,`contact_contacts`.`note` AS `note`,`contact_contacts`.`created_at` AS `created_at`,`contact_contacts`.`updated_at` AS `updated_at`,`contact_people`.`prefix` AS `prefix`,`contact_people`.`firstname` AS `firstname`,`contact_people`.`middlename` AS `middlename`,`contact_people`.`lastname` AS `lastname`,`contact_people`.`doc_cpf` AS `doc_cpf`,`contact_people`.`doc_rg` AS `doc_rg` from `contact_contacts` join `contact_people` where (`contact_contacts`.`id` = `contact_people`.`id`)", :force => true
end
