class Task
  module Start
    def self.call
      Task::Consumers::Events.start('task')

      DataCommand::Consumer.start('taskData')
    end
  end
end
