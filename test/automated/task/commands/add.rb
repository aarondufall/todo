require_relative '../../../test_helper'

describe "Task" do
  describe "Commands" do
    describe "Add" do
      specify "Added event is written to task stream" do
        task_id = Identifier::UUID::Random.get
        name = Controls::Task::Name.example

        Task::Commands::Add.(name, task_id: task_id)

        added_data = MessageStore::Postgres::Get::Last.("task-#{task_id}")
        refute(added_data.nil?)

        added = Messaging::Message::Import.(added_data, Task::Messages::Events::Added)

        assert(added.task_id == task_id)
        assert(added.name == name)
      end
    end
  end
end
