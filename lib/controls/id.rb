require 'identifier/uuid/controls'

module Controls
  module ID
    def self.example
      Identifier::UUID::Controls::Incrementing.example
    end
  end
end
