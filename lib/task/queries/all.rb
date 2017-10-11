class Task
  module Queries
    class All
      attr_reader :relation

      dependency :store, Task::Store

      def initialize(relation)
        @relation = relation
      end

      def self.build(relation: nil)
        relation ||= MessagesTable.by_category('task')

        instance = new(relation)
        Task::Store.configure(instance)
        instance
      end

      def self.call(relation: nil)
        instance = build(relation: relation)

        instance.()
      end

      def call
        records = relation.where(type: "Added").select(:stream_name).to_a

        records.flat_map do |record|
          stream_name = record.stream_name

          task_id = Messaging::StreamName.get_id(stream_name)

          task = store.fetch(task_id)

          if task.removed?
            []
          else
            [task]
          end
        end
      end
    end
  end
end
