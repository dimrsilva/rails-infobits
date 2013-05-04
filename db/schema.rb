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

ActiveRecord::Schema.define(:version => 20130504054626) do

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
    t.integer "representant_id"
    t.index ["representant_id"], :name => "fk__contact_companies_representant_id"
    t.foreign_key ["representant_id"], "contact_people", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_contact_companies_representant_id"
  end

  create_table "contact_contacts", :force => true do |t|
    t.string   "type"
    t.string   "fullname"
    t.date     "birthdate"
    t.text     "note"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "contact_groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.boolean  "acts_as_colaborator"
  end

  create_table "contact_contacts_groups", :force => true do |t|
    t.integer "contact_contact_id", :null => false
    t.integer "contact_group_id",   :null => false
    t.index ["contact_contact_id"], :name => "fk__contact_contacts_groups_contact_contact_id"
    t.index ["contact_group_id"], :name => "fk__contact_contacts_groups_contact_group_id"
    t.foreign_key ["contact_contact_id"], "contact_contacts", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_contact_contacts_groups_contact_contact_id"
    t.foreign_key ["contact_group_id"], "contact_groups", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_contact_contacts_groups_contact_group_id"
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

  create_table "domains", :force => true do |t|
    t.string   "type"
    t.string   "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "projects_projects", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "manager_id"
    t.integer  "status_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.index ["manager_id"], :name => "fk__projects_projects_manager_id"
    t.index ["status_id"], :name => "fk__projects_projects_status_id"
    t.foreign_key ["manager_id"], "contact_contacts", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_projects_projects_manager_id"
    t.foreign_key ["status_id"], "domains", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_projects_projects_status_id"
  end

  create_table "projects_colaborators", :force => true do |t|
    t.integer "contact_contact_id",  :null => false
    t.integer "projects_project_id", :null => false
    t.index ["contact_contact_id"], :name => "fk__projects_colaborators_contact_contact_id"
    t.index ["projects_project_id"], :name => "fk__projects_colaborators_projects_project_id"
    t.foreign_key ["contact_contact_id"], "contact_contacts", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_projects_colaborators_contact_contact_id"
    t.foreign_key ["projects_project_id"], "projects_projects", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_projects_colaborators_projects_project_id"
  end

  create_table "projects_task_statuses", :force => true do |t|
    t.integer "percent"
  end

  create_table "projects_tasks", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "estimated_time"
    t.integer  "real_time"
    t.integer  "project_id"
    t.integer  "responsible_id"
    t.integer  "task_status_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.index ["project_id"], :name => "fk__projects_tasks_project_id"
    t.index ["responsible_id"], :name => "fk__projects_tasks_responsible_id"
    t.index ["task_status_id"], :name => "fk__projects_tasks_task_status_id"
    t.foreign_key ["project_id"], "projects_projects", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_projects_tasks_project_id"
    t.foreign_key ["responsible_id"], "contact_contacts", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_projects_tasks_responsible_id"
    t.foreign_key ["task_status_id"], "projects_task_statuses", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_projects_tasks_task_status_id"
  end

  create_view "view_contact_companies", "select `contact_contacts`.`id` AS `id`,`contact_contacts`.`type` AS `type`,`contact_contacts`.`fullname` AS `fullname`,`contact_contacts`.`birthdate` AS `birthdate`,`contact_contacts`.`note` AS `note`,`contact_contacts`.`created_at` AS `created_at`,`contact_contacts`.`updated_at` AS `updated_at`,`contact_companies`.`fantasy_name` AS `fantasy_name`,`contact_companies`.`legal_name` AS `legal_name`,`contact_companies`.`doc_cnpj` AS `doc_cnpj`,`contact_companies`.`doc_ie` AS `doc_ie`,`contact_companies`.`doc_im` AS `doc_im`,`contact_companies`.`representant_id` AS `representant_id` from `contact_contacts` join `contact_companies` where (`contact_contacts`.`id` = `contact_companies`.`id`)", :force => true
  create_view "view_contact_people", "select `contact_contacts`.`id` AS `id`,`contact_contacts`.`type` AS `type`,`contact_contacts`.`fullname` AS `fullname`,`contact_contacts`.`birthdate` AS `birthdate`,`contact_contacts`.`note` AS `note`,`contact_contacts`.`created_at` AS `created_at`,`contact_contacts`.`updated_at` AS `updated_at`,`contact_people`.`prefix` AS `prefix`,`contact_people`.`firstname` AS `firstname`,`contact_people`.`middlename` AS `middlename`,`contact_people`.`lastname` AS `lastname`,`contact_people`.`doc_cpf` AS `doc_cpf`,`contact_people`.`doc_rg` AS `doc_rg` from `contact_contacts` join `contact_people` where (`contact_contacts`.`id` = `contact_people`.`id`)", :force => true
  create_view "view_contact_property_addresses", "select `contact_property_properties`.`id` AS `id`,`contact_property_properties`.`type` AS `type`,`contact_property_properties`.`label` AS `label`,`contact_property_properties`.`value` AS `value`,`contact_property_properties`.`contact_contact_id` AS `contact_contact_id`,`contact_property_properties`.`created_at` AS `created_at`,`contact_property_properties`.`updated_at` AS `updated_at`,`contact_property_addresses`.`street` AS `street`,`contact_property_addresses`.`neighborhood` AS `neighborhood`,`contact_property_addresses`.`postal_code` AS `postal_code`,`contact_property_addresses`.`city` AS `city`,`contact_property_addresses`.`state` AS `state`,`contact_property_addresses`.`country` AS `country` from `contact_property_properties` join `contact_property_addresses` where (`contact_property_properties`.`id` = `contact_property_addresses`.`id`)", :force => true
  create_view "view_projects_task_statuses", "select `domains`.`id` AS `id`,`domains`.`type` AS `type`,`domains`.`value` AS `value`,`domains`.`created_at` AS `created_at`,`domains`.`updated_at` AS `updated_at`,`projects_task_statuses`.`percent` AS `percent` from `domains` join `projects_task_statuses` where (`domains`.`id` = `projects_task_statuses`.`id`)", :force => true
end
