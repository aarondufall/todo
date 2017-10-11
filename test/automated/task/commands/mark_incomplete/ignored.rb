require_relative '../../../../test_helper'

describe "Task" do
  describe "Commands" do
    describe "Mark Incomplete" do
      describe "Ignored" do
        task_id = Controls::ID.example

        mark_incomplete = Task::Commands::MarkIncomplete.new(task_id)

        task = Controls::Task::MarkedIncomplete.example
        mark_incomplete.store.add(task_id, task)

        mark_incomplete.()

        writer = mark_incomplete.write

        specify "Nothing is written" do
          refute(writer.written?)
        end
      end
    end
  end
end
