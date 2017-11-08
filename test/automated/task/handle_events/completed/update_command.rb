require_relative '../../../../test_helper'

describe "Task" do
  describe "Handle Events" do
    describe "Completed" do
      describe "Update Command" do
        let :completed do
          Controls::Task::Events::Completed.example
        end

        let :handler do
          Task::Handlers::Events.new
        end

        let :update_command do
          handler.write.one_message do |message|
            message.instance_of?(ViewData::Commands::Update)
          end
        end

        before do
          handler.(completed)
        end

        specify "Update command message is written" do
          refute(update_command.nil?)
        end

        specify "Written to task data stream" do
          written_to_stream = handler.write.written?(update_command) do |stream_name|
            stream_name == "taskData-#{completed.task_id}"
          end

          assert(written_to_stream)
        end

        describe "Attributes" do
          specify "Identifier" do
            assert(update_command.identifier == completed.task_id)
          end

          specify "Name" do
            assert(update_command.name == 'tasks')
          end

          specify "Data" do
            control_data = {
              :completed_flag => true,
              :updated_at => completed.time
            }

            assert(update_command.data == control_data)
          end
        end
      end
    end
  end
end
