require_relative '../../../test_helper'

describe "Task" do
  describe "Commands" do
    describe "Add" do
      task_id = Controls::ID.example
      name = Controls::Task::Name.example

      add = Task::Commands::Add.new(task_id, name)

      effective_time = Controls::Time.example

      add.clock.now = effective_time

      add.()

      writer = add.write

      added = writer.one_message do |event|
        event.instance_of?(Task::Messages::Events::Added)
      end

      specify "Added event is written" do
        refute(added.nil?)
      end

      specify "Written to task stream" do
        written_to_stream = writer.written?(added) do |stream_name|
          stream_name == "task-#{task_id}"
        end

        assert(written_to_stream)
      end

      specify "Attributes" do
        assert(added.task_id == task_id)
        assert(added.name == name)

        effective_time_iso8601 = Clock.iso8601(effective_time)
        assert(added.time == effective_time_iso8601)
      end
    end
  end
end
