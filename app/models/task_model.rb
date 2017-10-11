class TaskModel < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  self.table_name = 'tasks'
end
