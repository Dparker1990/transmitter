require 'fixtures/controllers'
require 'rspec/rails'
require 'spec_helper'

describe TestsController, type: :controller do
  describe 'GET space_beacon' do
    before do
      Counter.instance.reset
      get :space_beacon
    end

    it 'sets the content-type to text/event-stream' do
      response.headers['Content-Type'].should eq 'text/event-stream'
    end

    it 'sends the next messages in the que concerning the current modal' do
      sleep 0.1 until response.stream.closed?
      response.body.should eq %{id: 1\nevent: space\nretry: 1000\ndata: {"expanding":true}\n\n}
    end
  end
end
