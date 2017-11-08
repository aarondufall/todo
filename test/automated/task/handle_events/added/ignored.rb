require_relative '../../../../test_helper'

describe "Task" do
  describe "Handle Events" do
    describe "Added" do
      describe "Ignored" do
        let :added do
          Controls::Task::Events::Added.example(position: 0)
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
          previous_message = Controls::MessageData.example(causation_message_position: 0)

          get_last = handler.get_last
          get_last.set("taskData-#{added.task_id}", previous_message)

          handler.(added)
        end

        specify "Nothing is written" do
          assert(create_command.nil?)
        end
      end
    end
  end
end
