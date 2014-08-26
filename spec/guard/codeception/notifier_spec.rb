require 'spec_helper'

describe Guard::Codeception::Notifier do

  let (:results) {
    {
      tests: 100,
      assertions: 1000,
      errors: 0,
      failures: 0,
      time: '10 ms'
    }
  }

  describe '#notify' do

    it 'should give proper message' do
      message = "100 tests, "
      message << "1000 assertions "
      message << "in 10 ms"

      ::Guard::Notifier::should_receive(:notify).with(message, {image: :success, title: Guard::Codeception::Notifier::TITLE})
      subject.notify(results)
    end

    it 'should give success message' do
      ::Guard::Notifier::should_receive(:notify).with(message(results), {image: :success, title: Guard::Codeception::Notifier::TITLE})
      subject.notify(results)
    end

    it 'should give failed message' do
      @results = results.merge(failures: 1)
      ::Guard::Notifier::should_receive(:notify).with(message(@results), {image: :failed, title: Guard::Codeception::Notifier::TITLE})
      subject.notify(@results)
    end

    it 'should give error message' do
      @results = results.merge(errors: 1)
      ::Guard::Notifier::should_receive(:notify).with(message(@results), {image: :failed, title: Guard::Codeception::Notifier::TITLE})
      subject.notify(@results)
    end

  end

  # taken from the class to make testing easier
  def message(results)
    message = []
    message << "#{results[:tests]} tests"
    message << "#{results[:assertions]} assertions"
    message << "#{results[:failures]} failures" if results[:failures] > 0
    message << "#{results[:errors]} errors" if results[:errors] > 0
    message.join(', ') << " in #{results[:time]}"
  end

end