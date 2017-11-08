class Task
  module Handlers
    class Events
      include Messaging::Handle
      include Messaging::StreamName

      include Messages::Events

      dependency :write, Messaging::Postgres::Write

      def configure
        Messaging::Postgres::Write.configure(self)
      end

      category :task_data

      handle Added do |added|
        task_id = added.task_id

        create_command = ViewData::Commands::Create.follow(added, strict: false)

        create_command.identifier = task_id

        create_command.name = 'tasks'

        create_command.data = {
          :name => added.name,
          :created_at => added.time
        }

        stream_name = stream_name(task_id)

        write.(create_command, stream_name)
      end
    end
  end
end
