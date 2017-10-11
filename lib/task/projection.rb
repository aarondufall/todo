class Task
  class Projection
    include EntityProjection

    entity_name :task

    apply Messages::Events::Added do |added|
      task.id = added.task_id
      task.name = added.name

      added_time_iso8601 = added.time
      added_time = Time.parse(added_time_iso8601)

      task.added_time = added_time
    end
  end
end
