require_relative '../../../../test_helper'

describe "Task" do
  describe "Commands" do
    describe "Complete" do
      describe "Ignored" do
        task_id = Controls::ID.example

        complete = Task::Commands::Complete.new(task_id)

        task = Controls::Task::Completed.example
        complete.store.add(task_id, task)

        complete.()

        writer = complete.write

        specify "Nothing is written" do
          refute(writer.written?)
        end
      end
    end
  end
end
