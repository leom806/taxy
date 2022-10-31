# this is a custom Broadcaster that allow switch the Wisper
# Event System to a <async> approach and setup a retry process
module Wisper
  class ActiveJobBroadcaster
    def broadcast(subscriber, _publisher, event, args)
      options = args.extract_options!
      delay_time = options.dig(:delay_time)

      if delay_time.present? && !delay_time.zero?
        Wrapper.set(wait: delay_time).perform_later(subscriber.name, event, args)
      else
        Wrapper.perform_later(subscriber.name, event, args)
      end
    end

    class Wrapper < ::ActiveJob::Base
      queue_as :default

      def perform(class_name, event, args)
        listener = class_name.constantize
        listener.public_send(event, *args)
      end
    end

    def self.register
      Wisper.configure do |config|
        config.broadcaster :active_job, ActiveJobBroadcaster.new
        config.broadcaster :async, ActiveJobBroadcaster.new
      end
    end
  end
end

Wisper::ActiveJobBroadcaster.register

# don't allow subscribe to events if it's Test Environment in order to
# maintain independence between tests and avoid unnecessary mocking
unless Rails.env.test?
  # we need requiring files to avoid
  # "Initialization autoloaded..." deprecation warning

  Dir["engines/*"].each do |engine_path|
    engine_name = engine_path.gsub("engines/", "")

    require "#{engine_name}/listeners"

    engine_listeners_module = "#{engine_name.camelize}::Listeners".constantize
    Wisper.subscribe(engine_listeners_module, async: true, prefix: :on)
  end
end
