require "alerty/plugin/mail/version"

require 'alerty'
require 'mail'

class Alerty
  class Plugin
    class Mail
      def initialize(config)
        raise ConfigError.new('mail: send_from is not configured') unless config.send_from
        raise ConfigError.new('mail: send_to is not configured') unless config.send_to
        delivery_method = config.delivery_method.to_sym || :sendmail
        delivery_settings = config.delivery_settings
        num_retries = config.num_retries || 3

        @mail = ::Mail.new do
          from    config.send_from
          to      config.send_to
        end
        if delivery_settings
          @mail.delivery_method(delivery_method, delivery_settings.map {|k, v| [k.to_sym, v] }.to_h)
        else
          @mail.delivery_method(delivery_method)
        end
        @num_retries = num_retries
        @subject = config.subject
      end

      def alert(record)
        subject = expand_placeholder(@subject, record) if @subject
        message = record[:output]
        retries = 0
        begin
          @mail.subject = subject if @subject
          @mail.body = message
          @mail.deliver!
        rescue => e
          retries += 1
          sleep 1
          if retries <= @num_retries
            retry
          else
            raise e
          end
        end
      end

      private

      def expand_placeholder(str, record)
        str.gsub('${hostname}', record[:hostname]).gsub!('${command}', record[:command])
      end
    end
  end
end
