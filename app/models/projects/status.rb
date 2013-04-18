class Projects::Status < Domain
  default_scope :conditions => ["type = ?","Projects::Status"]
end
