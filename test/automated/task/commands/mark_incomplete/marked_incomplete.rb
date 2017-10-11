require_relative '../../../../test_helper'

describe "Task" do
  describe "Commands" do
    describe "Mark Incomplete" do
      describe "Marked Incomplete" do
        task_id = Controls::ID.example

        mark_incomplete = Task::Commands::MarkIncomplete.new(task_id)

        task = Controls::Task::Completed.example
        mark_incomplete.store.add(task_id, task)

        effective_time = Controls::Time.example

        mark_incomplete.clock.now = effective_time

        mark_incomplete.()

        writer = mark_incomplete.write

        marked_incomplete = writer.one_message do |event|
          event.instance_of?(Task::Messages::Events::MarkedIncomplete)
        end

        specify "Marked Incomplete event is written" do
          refute(marked_incomplete.nil?)
        end

        specify "Written to task stream" do
          written_to_stream = writer.written?(marked_incomplete) do |stream_name|
            stream_name == "task-#{task_id}"
          end

          assert(written_to_stream)
        end

        specify "Attributes" do
          assert(marked_incomplete.task_id == task_id)

          effective_time_iso8601 = Clock.iso8601(effective_time)
          assert(marked_incomplete.time == effective_time_iso8601)
        end
      end
    end
  end
end
