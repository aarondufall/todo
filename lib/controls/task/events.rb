module Controls
  module Task
    module Events
      module Added
        def self.example(position: nil)
          added = ::Task::Messages::Events::Added.new

          added.task_id = Controls::ID.example
          added.name = Controls::Task::Name.example
          added.time = Controls::Time::ISO8601.example

          unless position.nil?
            added.metadata.position = position
          end

          added
        end
      end

      module Completed
        def self.example
          completed = ::Task::Messages::Events::Completed.new

          completed.task_id = Controls::ID.example
          completed.time = Controls::Time::ISO8601.example

          completed
        end
      end

      module MarkedIncomplete
        def self.example
          marked_incomplete = ::Task::Messages::Events::MarkedIncomplete.new

          marked_incomplete.task_id = Controls::ID.example
          marked_incomplete.time = Controls::Time::ISO8601.example

          marked_incomplete
        end
      end

      module Removed
        def self.example
          removed = ::Task::Messages::Events::Removed.new

          removed.task_id = Controls::ID.example
          removed.time = Controls::Time::ISO8601.example

          removed
        end
      end
    end
  end
end
