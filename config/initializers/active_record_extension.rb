module ActiveRecordExtension
  extend ActiveSupport::Concern

  module ClassMethods
    def field_name
      @@field_name
    end
    def field_name= val
      @@field_name = val
    end
  end
end

ActiveRecord::Base.send(:include, ActiveRecordExtension)
