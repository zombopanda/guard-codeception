require 'spec_helper'

describe Guard::Codeception::Parser do

  describe '#parse' do

    it 'should give 0 if nothing exists in the tests' do
      results = subject.parse('')
      results[:errors].should eq(-1)
    end

    context 'when codecept tests pass' do

      let (:codecept) { IO.read(Dir.getwd + '/spec/fixtures/results/codeception_success') }

      it 'parses the codecept run results' do
        result = subject.parse(codecept)
        expect(result).to eq({tests: 14, assertions: 36, failures: 0, errors: 0, time: '13.79 seconds'})
      end
    end

    context 'when codecept tests fail' do

      let (:codecept) { IO.read(Dir.getwd + '/spec/fixtures/results/codeception_failure') }

      it 'parses the codecept run results' do
          result = subject.parse(codecept)
          expect(result).to eq({tests: 14, assertions: 35, failures: 1, errors: 0, time: '13.65 seconds'})
      end

    end

    context 'when codecept tests error' do

      let (:codecept) { IO.read(Dir.getwd + '/spec/fixtures/results/codeception_error') }

      it 'parses the codecept run results' do
          result = subject.parse(codecept)
          expect(result).to eq({tests: 1, assertions: 0, failures: 0, errors: 1, time: '145 ms'})
      end

    end

    context 'when codecept tests fatal' do

      let (:codecept) { IO.read(Dir.getwd + '/spec/fixtures/results/codeception_fatal') }

      it 'parses the codecept run results' do
          result = subject.parse(codecept)
          expect(result).to eq({tests: 0, assertions: 0, failures: 0, errors: -1, time: 0})
      end

    end

    # @todo
    # it 'should give values if they exists' do
    #   keys = [:tests, :assertions, :failures, :errors]
    #
    #   keys.each do |key|
    #     results = subject.parse("OK #{key.to_s.capitalize}: 42 bar")
    #     results[key].should eq(42)
    #   end
    #
    # end
  end

end