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

    specify "Completed" do
      entity = Task.new

      completed = Controls::Task::Events::Completed.example

      Task::Projection.(entity, completed)

      time = Time.parse(completed.time) or fail

      assert(entity.completed_time == time)
    end

    specify "MarkedIncomplete" do
      entity = Task.new
      entity.completed_time = Controls::Time.example

      marked_incomplete = Controls::Task::Events::MarkedIncomplete.example

      Task::Projection.(entity, marked_incomplete)

      time = Time.parse(marked_incomplete.time) or fail

      assert(entity.completed_time.nil?)
    end
  end
end
