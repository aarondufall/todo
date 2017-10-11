class Task
  class Store
    include EntityStore

    category :task
    entity Task
    projection Task::Projection
    reader MessageStore::Postgres::Read
  end
end
