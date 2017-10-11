require_relative '../../../test_helper'

describe "Task" do
  describe "Entity" do
    describe "Remove" do
      time = Controls::Time.example

      specify "Not removed task becomes removed" do
        task = Controls::Task::Removed::Not.example
        refute(task.removed?)

        task.remove(time)

        assert(task.removed?)
      end

      specify "Already removed task remains removed" do
        task = Controls::Task::Removed.example
        assert(task.removed?)

        task.remove(time)

        assert(task.removed?)
      end
    end
  end
end
