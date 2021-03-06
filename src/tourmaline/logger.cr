require "strange"
require "strange/formatter/color_formatter"

module Tourmaline
  module Logger
    @@logger = Strange.new("env", transports: [
      Strange::ConsoleTransport.new(formatter: Formatter.new).as(Strange::Transport),
    ])

    def logger
      @@logger
    end

    delegate :emerg, :alert, :crit, :error, :warning, :notice, :info, :debug, to: @@logger

    {% for level in [:emerg, :alert, :crit, :error, :warning, :notice, :info, :debug] %}
      def self.{{ level.id }}(message)
        @@logger.{{ level.id }}(message)
      end
    {% end %}

    class Formatter < Strange::ColorFormatter
      def format(text : String, level : Strange::Level)
        lvl = "[" + ("%-7.7s" % level.to_s) + "]"
        color_message("#{lvl} - #{text}", level)
      end
    end
  end
end
