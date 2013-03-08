module ActiveRecordExtension
  extend ActiveSupport::Concern

  module ClassMethods
    def self.field_name
      @@field_name
    end
    def self.field_name= val
      @@field_name = val
    end
  end
end

ActiveRecord::Base.send(:include, ActiveRecordExtension)