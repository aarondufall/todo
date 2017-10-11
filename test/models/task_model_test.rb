require 'test_helper'

class TaskModelTest < ActiveSupport::TestCase
  test 'invalid without a name' do
    t = TaskModel.new
    assert !t.valid?, "Name is not being validated!"
  end

  test 'name is unique' do
    assert  TaskModel.create(name: "Unique").valid?
    assert !TaskModel.create(name: "Unique").valid?,
      "Name uniqueness is not being validated!"
  end
end
