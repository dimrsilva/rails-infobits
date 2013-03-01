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

  create_table "companies", :force => true do |t|
    t.string "fantasy_name"
    t.string "legal_name"
    t.string "doc_cnpj"
    t.string "doc_ie"
    t.string "doc_im"
  end

  create_table "contacts", :force => true do |t|
    t.string   "type"
    t.string   "fullname"
    t.date     "birthdate"
    t.text     "note"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "people", :force => true do |t|
    t.string "prefix"
    t.string "firstname"
    t.string "middlename"
    t.string "lastname"
    t.string "doc_cpf"
    t.string "doc_rg"
  end

  create_view "view_companies", "select `contacts`.`id` AS `id`,`contacts`.`type` AS `type`,`contacts`.`fullname` AS `fullname`,`contacts`.`birthdate` AS `birthdate`,`contacts`.`note` AS `note`,`contacts`.`created_at` AS `created_at`,`contacts`.`updated_at` AS `updated_at`,`companies`.`fantasy_name` AS `fantasy_name`,`companies`.`legal_name` AS `legal_name`,`companies`.`doc_cnpj` AS `doc_cnpj`,`companies`.`doc_ie` AS `doc_ie`,`companies`.`doc_im` AS `doc_im` from `contacts` join `companies` where (`contacts`.`id` = `companies`.`id`)", :force => true
  create_view "view_people", "select `contacts`.`id` AS `id`,`contacts`.`type` AS `type`,`contacts`.`fullname` AS `fullname`,`contacts`.`birthdate` AS `birthdate`,`contacts`.`note` AS `note`,`contacts`.`created_at` AS `created_at`,`contacts`.`updated_at` AS `updated_at`,`people`.`prefix` AS `prefix`,`people`.`firstname` AS `firstname`,`people`.`middlename` AS `middlename`,`people`.`lastname` AS `lastname`,`people`.`doc_cpf` AS `doc_cpf`,`people`.`doc_rg` AS `doc_rg` from `contacts` join `people` where (`contacts`.`id` = `people`.`id`)", :force => true
end
