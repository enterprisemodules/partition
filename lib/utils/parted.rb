require 'pathname'
$:.unshift(Pathname.new(__FILE__).dirname.parent.parent)
$:.unshift(Pathname.new(__FILE__).dirname.parent.parent.parent.parent + 'easy_type' + 'lib')
require 'easy_type'
require 'utils/parted_command'

module Utils
  class Parted
    include Utils::PartedCommand

    PARTITION_COLUMNS = ['minor','start','end','size','part_type','fs_type', 'flags', 'device']
    TABLE_COLUMNS     = ['device','type']
    TABLE_HEADER      = /^(Number\s*)(Start\s*)(End\s*)(Size\s*)(Type*\s*)*(File\s*system\s*)\s*(Name\s*)*(Flags\s*)$/
    PARTITION_TABLE   = /^Partition Table: (.*)$/
    DEVICE_NAME       = /^Disk \/dev\/(.*):.*$/
    InstancesResults  = EasyType::Helpers::InstancesResults

    attr_reader :partitions, :tables

    def initialize
      reset
    end

    def wait_for_device(device, device_timeout)
      device_timeout.times do
        return if File.exists?(device)
        sleep 1
      end
    end

    def list
      reset
      @output = parted '-l'
      parse_output
    end

    def show(device, unit = 'mb')
      reset
      @output= parted device, "unit #{unit} print"
      parse_output
    end

    private


    def reset
      @partition_columns = []
      @current_device_name = ''
      @partition_type = ''
      @in_table = false
      @partitions = []
      @tables = []
      @output = ''
    end

    def parse_output
      unless @parsed
        @output.each_line do | line|
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
      device = line.scan(DEVICE_NAME).flatten.first
      if device
        @current_device_name = "/dev/#{device}"
        @partition_type = nil
      end
    end

    def partition_table_filter(line)
      type = line.scan(PARTITION_TABLE).flatten.first
      if type
        @partition_type = type
        table_data = [@current_device_name, @partition_type]
        @tables << InstancesResults[TABLE_COLUMNS.zip(table_data)]
      end
    end

    def start_of_table_filter(line)
      start_of_table = TABLE_HEADER.match(line)
      if start_of_table
        @in_table = true
        @offsets = extract_positions(start_of_table)
        @partition_columns = normalize_columns(start_of_table)
      end
    end

    def extract_positions(match_data)
      (1..match_data.length-1).map {|n| match_data.offset(n)}
    end

    def normalize_columns(data)
      data.captures.map{|e| e.nil? ? '': e}.map(&:downcase).map(&:strip) << 'device'
    end

    def end_of_table_filter(line)
      @in_table = false if @in_table and line == ""
    end

    def table_line_filter(line)
      if @in_table
        data = extract_content(line)
        data.map!(&:strip)
        data << @current_device_name
        @partition_columns[6] = 'type' if @partition_type == 'gpt'
        @partitions << InstancesResults[@partition_columns.zip(data)]
      end
    end

    def extract_content(line)
      data = []
      @offsets.each do | (begin_pos, end_pos)|
        if begin_pos.nil? || begin_pos >= line.length
          data << ''
        else
          length = end_pos - begin_pos
          data << line.slice(begin_pos, length).strip
        end
      end
      data
    end
  end
end
