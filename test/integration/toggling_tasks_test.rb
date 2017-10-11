require 'test_helper'

class TogglingTasksTest < ActionDispatch::IntegrationTest
  test 'can mark incomplete task as complete on index page' do
    undone = TaskModel.create!(name: "You Must Complete Me!")
    get tasks_path
    assert_response :success

    patch task_path(undone.id), { completed_flag: true }
    assert_redirected_to(tasks_path)
    assert(TaskModel.find(undone.id).completed_flag)
  end

  test 'can mark complete task as incomplete on index page' do
    done = TaskModel.create!(name: "I'm not resolved yet!",
                        completed_flag: true)
    get tasks_path
    assert_response :success

    patch task_path(done), { completed_flag: false }
    assert_redirected_to(tasks_path)
    assert_not(TaskModel.find(done.id).completed_flag)
  end
end
