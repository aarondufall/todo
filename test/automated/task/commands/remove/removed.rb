require_relative '../../../../test_helper'

describe "Task" do
  describe "Commands" do
    describe "Remove" do
      describe "Removed" do
        task_id = Controls::ID.example

        remove = Task::Commands::Remove.new(task_id)

        task = Controls::Task::Removed::Not.example
        remove.store.add(task_id, task)

        effective_time = Controls::Time.example

        remove.clock.now = effective_time

        remove.()

        writer = remove.write

        removed = writer.one_message do |event|
          event.instance_of?(Task::Messages::Events::Removed)
        end

        specify "Removed event is written" do
          refute(removed.nil?)
        end

        specify "Written to task stream" do
          written_to_stream = writer.written?(removed) do |stream_name|
            stream_name == "task-#{task_id}"
          end

          assert(written_to_stream)
        end

        specify "Attributes" do
          assert(removed.task_id == task_id)

          effective_time_iso8601 = Clock.iso8601(effective_time)
          assert(removed.time == effective_time_iso8601)
        end
      end
    end
  end
end
