require 'json'

module Transmitter
  class SSE
    attr_reader :response_stream, :message

    def initialize(response_stream)
      @response_stream = response_stream
    end

    def stream
      response_stream.write message
    end

    def close
      response_stream.close
    end

    def build_message(opts)
      @message = "id: #{next_id}\n"
      @message << "event: #{opts[:event]}\n"
      @message << "retry: #{opts[:retry]}\n" if opts.has_key? :retry
      @message << "data: #{opts[:data].to_json}\n\n"
      self
    end

    private

    def next_id
      counter.next
    end

    def counter
      Counter.instance
    end
  end
end
