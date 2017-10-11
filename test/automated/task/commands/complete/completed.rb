require_relative '../../../../test_helper'

describe "Task" do
  describe "Commands" do
    describe "Complete" do
      describe "Completed" do
        task_id = Controls::ID.example

        complete = Task::Commands::Complete.new(task_id)

        task = Controls::Task::Added.example
        complete.store.add(task_id, task)

        effective_time = Controls::Time.example

        complete.clock.now = effective_time

        complete.()

        writer = complete.write

        completed = writer.one_message do |event|
          event.instance_of?(Task::Messages::Events::Completed)
        end

        specify "Completed event is written" do
          refute(completed.nil?)
        end

        specify "Written to task stream" do
          written_to_stream = writer.written?(completed) do |stream_name|
            stream_name == "task-#{task_id}"
          end

          assert(written_to_stream)
        end

        specify "Attributes" do
          assert(completed.task_id == task_id)

          effective_time_iso8601 = Clock.iso8601(effective_time)
          assert(completed.time == effective_time_iso8601)
        end
      end
    end
  end
end
