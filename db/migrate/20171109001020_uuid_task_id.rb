class UuidTaskId < ActiveRecord::Migration
  def change
    change_column :tasks, :id, :varchar
  end
end
