class Task
  module Commands
    class Add
      attr_reader :task_id
      attr_reader :name

      def initialize(task_id, name)
        @task_id = task_id
        @name = name
      end

      def self.build(name, task_id: nil)
        task_id ||= Identifier::UUID::Random.get

        new(task_id, name)
      end

      def self.call(name, task_id: nil)
        instance = build(name, task_id: task_id)
        instance.()
      end

      def call
        time = ::Time.now
        time_iso8601 = time.iso8601

        added = Messages::Events::Added.new

        added.task_id = task_id
        added.name = name
        added.time = time_iso8601

        stream_name = "task-#{task_id}"

        write = Messaging::Postgres::Write.build

        write.initial(added, stream_name)
      end
    end
  end
end
