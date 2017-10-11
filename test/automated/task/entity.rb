require_relative '../../test_helper'

describe "Task" do
  describe "Entity" do
    specify "Complete" do
      task = Task.new
      refute(task.completed?)

      time = Controls::Time.example

      task.complete(time)

      assert(task.completed?)
    end

    specify "Mark Incomplete" do
      task = Task.new
      task.completed_time = Controls::Time.example
      assert(task.completed?)

      time = Controls::Time.example

      task.mark_incomplete

      refute(task.completed?)
    end
  end
end
