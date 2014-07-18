require 'pathname'
$:.unshift(Pathname.new(__FILE__).dirname.parent.parent)
$:.unshift(Pathname.new(__FILE__).dirname.parent.parent.parent.parent + 'easy_type' + 'lib')
require 'easy_type'

module Utils
  class Parted

    PARTITION_COLUMNS = ['minor','start','end','size','part_type','fs_type', 'flags', 'device']
    TABLE_COLUMNS     = ['device','type']
    InstancesResults = EasyType::Helpers::InstancesResults

    attr_reader :partitions, :tables

    def initialize
      @current_device_name = ''
      @partition_type = ''
      @in_table = false
      @partitions = []
      @tables = []
      parse_output
    end

    private

    def parted(*args)
      command = args.dup.unshift(:parted)
      Puppet::Util::Execution.execute(command)
    end


    def list
      parted '-l'
    end


    def parse_output
      unless @parsed
        list.each_line do | line|
          line && line.chop!
          end_of_table_filter(line)
          partition_table_filter(line)
          table_line_filter(line)
          device_name_filter(line)
          start_of_table_filter(line)
        end
      end
    end

    def device_name_filter(line)
      device = line.scan(/^Disk \/dev\/(.*):.*$/).flatten.first
      if device
        @current_device_name = device
        @partition_type = nil
      end
    end

    def partition_table_filter(line)
      type = line.scan(/^Partition Table: (.*)$/).flatten.first
      if type
        @partition_type = type
        table_data = [@current_device_name, @partition_type]
        @tables << InstancesResults[TABLE_COLUMNS.zip(table_data)]
      end
    end

    def start_of_table_filter(line)
      start_of_table = /^Number\s*Start\s*End\s*Size\s*Type\s*File\s*system\s*Flags$/.match(line)
      @in_table = true if start_of_table
    end

    def end_of_table_filter(line)
      @in_table = false if @in_table and line == ""
    end

    def table_line_filter(line)
      if @in_table
        data = line.scan(/^\s(\S*\s)\s*(\s\S*\s)\s*(\s\S*\s)\s*(\s\S*\s)\s*(\s\S*\s)\s*(\s\S*\s)\s*(\s\S*\s)/).flatten
        data.map!(&:strip)
        data << @current_device_name
        @partitions << InstancesResults[PARTITION_COLUMNS.zip(data)]
      end
    end
  end
end
