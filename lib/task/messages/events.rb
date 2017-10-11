class Task
  module Messages
    module Events
      class Added
        include Messaging::Message

        attribute :task_id, String
        attribute :name, String
        attribute :time, String
      end

      class Completed
        include Messaging::Message

        attribute :task_id, String
        attribute :time, String
      end

      class MarkedIncomplete
        include Messaging::Message

        attribute :task_id, String
        attribute :time, String
      end
    end
  end
end
