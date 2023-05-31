require 'benchmark'
require 'memory_profiler'

# require_relative 'lib/csv_generator'
require_relative 'lib/tasks/user_timing'
require_relative 'lib/tasks/task_timing'



file_path = 'tmp/data.csv'
# CsvGenerator.new(file_path).call
first_report = MemoryProfiler.report do
  UserTiming.new(file_path).print
end

second_report = MemoryProfiler.report do
  TaskTiming.new(file_path).print
end

# puts '               user     system      total        real'
# puts "UserTiming: #{user_timing_time}"
# puts "TaskTiming: #{task_timing_time}"

first_report.pretty_print(to_file: 'tmp/user_timing_report.txt')
second_report.pretty_print(to_file: 'tmp/task_timing_report.txt')