require_relative '../../../../test_helper'

describe "Task" do
  describe "Handle Events" do
    describe "Completed" do
      describe "Ignored" do
        let :completed do
          Controls::Task::Events::Completed.example(position: 0)
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
          previous_message = Controls::MessageData.example(causation_message_position: 0)

          get_last = handler.get_last
          get_last.set("taskData-#{completed.task_id}", previous_message)

          handler.(completed)
        end

        specify "Nothing is written" do
          assert(update_command.nil?)
        end
      end
    end
  end
end
