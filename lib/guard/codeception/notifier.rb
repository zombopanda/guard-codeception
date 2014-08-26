module Guard
  class Codeception
    class Notifier

      TITLE = 'Codeception Results'

      def notify(results)
        image     = _image(results)
        message   = _message(results)
        if results[:errors] == -1
          ::Guard::Notifier::notify('Failed', {title: TITLE, image: :failed})
        else
          ::Guard::Notifier::notify(message, {title: TITLE, image: image})
        end
      end

      private

      def _image(results)
        return :failed if results[:failures] > 0
        return :failed if results[:errors] > 0
        :success
      end

      def _message(results)
        message = []
        message << "#{results[:tests]} tests"
        message << "#{results[:assertions]} assertions"
        message << "#{results[:failures]} failures" if results[:failures] > 0
        message << "#{results[:errors]} errors" if results[:errors] > 0
        message.join(', ') << " in #{results[:time]}"
      end

    end
  end
end