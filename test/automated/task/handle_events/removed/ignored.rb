require_relative '../../../../test_helper'

describe "Task" do
  describe "Handle Events" do
    describe "Removed" do
      describe "Ignored" do
        let :removed do
          Controls::Task::Events::Completed.example(position: 0)
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
          previous_message = Controls::MessageData.example(causation_message_position: 0)

          get_last = handler.get_last
          get_last.set("taskData-#{removed.task_id}", previous_message)

          handler.(removed)
        end

        specify "Nothing is written" do
          assert(delete_command.nil?)
        end
      end
    end
  end
end
