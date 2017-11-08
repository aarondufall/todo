require_relative '../../../../test_helper'

describe "Task" do
  describe "Handle Events" do
    describe "Added" do
      describe "Create Command" do
        let :added do
          Controls::Task::Events::Added.example
        end

        let :handler do
          Task::Handlers::Events.new
        end

        let :create_command do
          handler.write.one_message do |message|
            message.instance_of?(ViewData::Commands::Create)
          end
        end

        before do
          handler.(added)
        end

        specify "Create command message is written" do
          refute(create_command.nil?)
        end

        specify "Written to task data stream" do
          written_to_stream = handler.write.written?(create_command) do |stream_name|
            stream_name == "taskData-#{added.task_id}"
          end

          assert(written_to_stream)
        end

        describe "Attributes" do
          specify "Identifier" do
            assert(create_command.identifier == added.task_id)
          end

          specify "Name" do
            assert(create_command.name == 'tasks')
          end

          specify "Data" do
            control_data = {
              :name => added.name,
              :created_at => added.time
            }

            assert(create_command.data == control_data)
          end
        end
      end
    end
  end
end
