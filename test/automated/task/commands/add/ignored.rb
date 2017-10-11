require_relative '../../../../test_helper'

describe "Task" do
  describe "Commands" do
    describe "Add" do
      describe "Ignored" do
        task_id = Controls::ID.example
        name = Controls::Task::Name.example

        add = Task::Commands::Add.new(task_id, name)

        task = Controls::Task::Added.example
        add.store.add(task_id, task)

        add.()

        writer = add.write

        specify "Nothing is written" do
          refute(writer.written?)
        end
      end
    end
  end
end
