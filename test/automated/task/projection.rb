require_relative '../../test_helper'

describe "Task" do
  describe "Projection" do
    specify "Added" do
      entity = Task.new

      task_id = '11111111-1111-4111-8111-111111111111'
      name = 'Some Task'

      time = Time.new(2000, 1, 1, 11, 11, 11)
      time_iso8601 = time.iso8601

      added = Task::Messages::Events::Added.new

      added.task_id = task_id
      added.name = name
      added.time = time_iso8601

      Task::Projection.(entity, added)

      assert(entity.id == task_id)
      assert(entity.name == name)
      assert(entity.added_time == time)
    end
  end
end
