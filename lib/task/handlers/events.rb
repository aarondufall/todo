class Task
  module Handlers
    class Events
      include Messaging::Handle
      include Messaging::StreamName

      include Messages::Events

      dependency :write, Messaging::Postgres::Write
      dependency :get_last, MessageStore::Postgres::Get::Last

      def configure
        Messaging::Postgres::Write.configure(self)
        MessageStore::Postgres::Get::Last.configure(self)
      end

      category :task_data

      handle Added do |added|
        task_id = added.task_id

        stream_name = stream_name(task_id)

        if current?(added)
          Rails.logger.info { "Ignored added event (Task ID: #{task_id})" }
          return
        end

        create_command = ViewData::Commands::Create.follow(added, strict: false)

        create_command.identifier = task_id

        create_command.name = 'tasks'

        create_command.data = {
          :name => added.name,
          :created_at => added.time
        }

        write.(create_command, stream_name)
      end

      def current?(event)
        task_id = event.task_id

        data_command_stream = stream_name(task_id)

        last_command = get_last.(data_command_stream)

        return false if last_command.nil?

        last_command_position = last_command.metadata[:causation_message_position]

        last_command_position >= event.metadata.position
      end
    end
  end
end
