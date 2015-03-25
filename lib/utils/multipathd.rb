module Utils
  class Multipathd

    def self.daemon_name(value=nil)
      if value 
        @daemon_name = value
      else
        @daemon_name || 'multipathd'
      end
    end

    def self.running?
      !`service #{daemon_name} status`.match(/running/).nil?
    end

  end
end