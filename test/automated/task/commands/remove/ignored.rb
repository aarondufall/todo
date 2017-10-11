require_relative '../../../../test_helper'

describe "Task" do
  describe "Commands" do
    describe "Remove" do
      describe "Ignored" do
        task_id = Controls::ID.example

        remove = Task::Commands::Remove.new(task_id)

        task = Controls::Task::Removed.example
        remove.store.add(task_id, task)

        remove.()

        writer = remove.write

        specify "Nothing is written" do
          refute(writer.written?)
        end
      end
    end
  end
end
