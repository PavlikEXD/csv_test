require 'benchmark'
require 'get_process_mem'

require_relative 'lib/csv_generator'
require_relative 'lib/tasks/user_timing'
require_relative 'lib/tasks/task_timing'



file_path = 'tmp/data.csv'
# CsvGenerator.new(file_path).call
first_check = GetProcessMem.new.bytes
# user_timing_time = Benchmark.measure { UserTiming.new(file_path).print }
UserTiming.new(file_path).print
second_check = GetProcessMem.new.bytes
# task_timing_time = Benchmark.measure { TaskTiming.new(file_path).print }
TaskTiming.new(file_path).print
third_check = GetProcessMem.new.bytes

# puts '               user     system      total        real'
# puts "UserTiming: #{user_timing_time}"
# puts "TaskTiming: #{task_timing_time}"

puts "Memory usage after UserTiming: #{second_check - first_check} bytes"
puts "Memory usage after TaskTiming: #{third_check - second_check} bytes"