class Task
  include Schema::DataStructure

  attribute :id, String
  attribute :name, String
  attribute :added_time, Time
  attribute :completed_time, Time
end
