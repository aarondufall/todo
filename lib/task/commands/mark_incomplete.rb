class Task
  module Commands
    class MarkIncomplete
      attr_reader :task_id

      dependency :clock, Clock::UTC
      dependency :store, Task::Store
      dependency :write, Messaging::Postgres::Write

      def initialize(task_id)
        @task_id = task_id
      end

      def self.build(task_id:)
        task_id ||= Identifier::UUID::Random.get

        instance = new(task_id)
        Clock::UTC.configure(instance)
        Store.configure(instance)
        Messaging::Postgres::Write.configure(instance)
        instance
      end

      def self.call(task_id: nil)
        instance = build(task_id: task_id)
        instance.()
      end

      def call
        task, version = store.fetch(task_id, include: :version)

        return unless task.completed?

        marked_incomplete = Messages::Events::MarkedIncomplete.new

        marked_incomplete.task_id = task_id
        marked_incomplete.time = clock.iso8601

        stream_name = "task-#{task_id}"

        write.(marked_incomplete, stream_name, expected_version: version)
      end
    end
  end
end
