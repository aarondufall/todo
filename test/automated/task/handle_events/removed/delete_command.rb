require_relative '../../../../test_helper'

describe "Task" do
  describe "Handle Events" do
    describe "Removed" do
      describe "Delete Command" do
        let :removed do
          Controls::Task::Events::Removed.example
        end

        let :handler do
          Task::Handlers::Events.new
        end

        let :delete_command do
          handler.write.one_message do |message|
            message.instance_of?(ViewData::Commands::Delete)
          end
        end

        before do
          handler.(removed)
        end

        specify "Update command message is written" do
          refute(delete_command.nil?)
        end

        specify "Written to task data stream" do
          written_to_stream = handler.write.written?(delete_command) do |stream_name|
            stream_name == "taskData-#{removed.task_id}"
          end

          assert(written_to_stream)
        end
      end
    end
  end
end
