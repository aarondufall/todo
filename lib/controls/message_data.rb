require 'message_store/controls'

module Controls
  module MessageData
    def self.example(causation_message_position: nil)
      message = ::MessageStore::Controls::MessageData::Read.example

      unless causation_message_position.nil?
        message.metadata[:causation_message_position] = causation_message_position
      end

      message
    end
  end
end
