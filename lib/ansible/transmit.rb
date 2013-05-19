module Ansible
  module Transmit
    def self.extended(base)
      base.class_eval do
        include ActionController::Live

        def self._beacons
          @_beacons ||= []
        end
      end
    end

    def transmit(name)
      @name = name
      _beacons << beacon_name.to_sym

      define_method beacon_name, beacon_action
    end

    private

    def beacon_name
      "#{@name}_ansible_beacon"
    end

    def beacon_action
      Proc.new do
        response.headers['Content-Type'] = 'text/event-stream'

        render nothing: true
      end
    end
  end
end
