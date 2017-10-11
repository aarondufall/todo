require 'clock/controls'

module Controls
  module Time
    def self.example
      Clock::Controls::Time::Raw.example
    end

    module ISO8601
      def self.example
        Clock::Controls::Time::ISO8601.example
      end
    end
  end
end
