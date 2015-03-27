module Utils
  module PartedCommand

    def self.included(parent)
      parent.extend(PartedCommand)
    end

    def parted(*args)
      options = args.last.is_a?(Hash) ? args.delete_at(-1) : {}
      options.merge!({:failonfail => false})
      command = args.dup.unshift(:parted).join(' ')
      @output = Puppet::Util::Execution.execute(command,options)
      check_errors(@output) if @output.exitstatus != 0
      @output
    end

    def check_errors(output)
      return if output =~ /unrecognised disk label/
      fail "parted failed with error #{output}"
    end
  end

end

