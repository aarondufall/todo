module Controls
  module Task
    def self.example(id: nil, name: nil, added_time: nil, completed_time: nil)
      Completed.example(id: id, name: name, added_time: added_time, completed_time: completed_time)
    end

    def self.id
      Controls::ID.example
    end

    module New
      def self.example
        ::Task.new
      end
    end

    module Added
      def self.example(id: nil, name: nil, added_time: nil)
        id ||= Controls::Task.id
        name ||= Controls::Task::Name.example
        added_time ||= Controls::Time.example

        task = New.example

        task.id = id
        task.name = name
        task.added_time = added_time

        task
      end
    end

    module Completed
      def self.example(id: nil, name: nil, added_time: nil, completed_time: nil)
        completed_time ||= Controls::Time.example

        task = Added.example(id: id, name: name, added_time: added_time)

        task.complete(completed_time)

        task
      end
    end

    module MarkedIncomplete
      def self.example(id: nil, name: nil, added_time: nil)
        task = Completed.example(id: id, name: name, added_time: added_time)

        task.mark_incomplete

        task
      end
    end
  end
end
