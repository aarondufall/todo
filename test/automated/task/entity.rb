require_relative '../../test_helper'

describe "Task" do
  describe "Entity" do
    describe "Complete" do
      time = Controls::Time.example

      specify "Not completed tasks become completed" do
        task = Controls::Task::Added.example
        refute(task.completed?)

        task.complete(time)

        assert(task.completed?)
      end

      specify "Completed tasks remain completed" do
        task = Controls::Task::Completed.example
        assert(task.completed?)

        task.complete(time)

        assert(task.completed?)
      end

      specify "Tasks marked incomplete become completed" do
        task = Controls::Task::MarkedIncomplete.example
        refute(task.completed?)

        task.complete(time)

        assert(task.completed?)
      end
    end

    describe "Mark incomplete" do
      specify "Completed task becomes incomplete" do
        task = Controls::Task::Completed.example
        assert(task.completed?)

        task.mark_incomplete

        refute(task.completed?)
      end

      specify "Tasks already marked incomplete remain not completed" do
        task = Controls::Task::MarkedIncomplete.example
        refute(task.completed?)

        task.mark_incomplete

        refute(task.completed?)
      end
    end
  end
end
