class MessagesTable < ActiveRecord::Base
  establish_connection(:message_store)

  self.table_name = 'messages'
  self.inheritance_column = :_sti_disabled

  def self.by_category(category)
    where("stream_name LIKE '#{category}%'")
  end
end
