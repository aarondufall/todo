module Controls
  module Task
    module Events
      module Added
        def self.example
          added = ::Task::Messages::Events::Added.new

          added.task_id = Controls::ID.example
          added.name = Controls::Task::Name.example
          added.time = Controls::Time::ISO8601.example

          added
        end
      end
    end
  end
end
