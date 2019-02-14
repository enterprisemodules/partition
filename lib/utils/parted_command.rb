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
      @output
    end

  end

end

