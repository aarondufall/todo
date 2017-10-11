class Task
  module Commands
    class Add
      attr_reader :task_id
      attr_reader :name

      dependency :clock, Clock::UTC
      dependency :write, Messaging::Postgres::Write

      def initialize(task_id, name)
        @task_id = task_id
        @name = name
      end

      def self.build(name, task_id: nil)
        task_id ||= Identifier::UUID::Random.get

        instance = new(task_id, name)
        Clock::UTC.configure(instance)
        Messaging::Postgres::Write.configure(instance)
        instance
      end

      def self.call(name, task_id: nil)
        instance = build(name, task_id: task_id)
        instance.()
      end

      def call
        added = Messages::Events::Added.new

        added.task_id = task_id
        added.name = name
        added.time = clock.iso8601

        stream_name = "task-#{task_id}"

        write.initial(added, stream_name)
      end
    end
  end
end
