require_relative '../../test_helper'

describe "Task" do
  describe "Projection" do
    specify "Added" do
      entity = Task.new

      added = Controls::Task::Events::Added.example

      Task::Projection.(entity, added)

      task_id = added.task_id or fail
      name = added.name or fail
      time = Time.parse(added.time) or fail

      assert(entity.id == task_id)
      assert(entity.name == name)
      assert(entity.added_time == time)
    end
  end
end
