class Task
  module Messages
    module Events
      class Added
        include Messaging::Message

        attribute :task_id, String
        attribute :name, String
        attribute :time, String
      end
    end
  end
end
