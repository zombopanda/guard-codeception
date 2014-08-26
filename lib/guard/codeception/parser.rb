module Guard
  class Codeception
    class Parser

      def parse(text)
        result = {
            tests:      _get(text, 'Tests'),
            assertions: _get(text, 'Assertions'),
            failures:   _get(text, 'Failures'),
            errors:     _get(text, 'Errors'),
            time:       _get_time(text)
        }
        p result
        result[:errors] = -1 if fatal? text
        result
      end

      private

      def fatal? text
        !text.to_s.match(/(FAILURES!|OK)/)
      end

      def _get (text, find)
        begin
          p text
          text.to_s.match(/(FAILURES!|OK).*?(((?<count>\d+) #{find.to_s}?)|(#{find.to_s}?: (?<count>\d+)[\.,]))/im)[:count].to_i
        rescue NoMethodError
          0
        end
      end

      def _get_time (text)
        begin
          text.to_s.match(/Time: (.+?),/)[1]
        rescue NoMethodError
          0
        end
      end

    end
  end
end