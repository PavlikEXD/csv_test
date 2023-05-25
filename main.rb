require 'benchmark'

require_relative 'lib/csv_generator'
require_relative 'lib/tasks/user_timing'
require_relative 'lib/tasks/task_timing'

file_path = 'tmp/data.csv'
# CsvGenerator.new(file_path).call
user_timing_time = Benchmark.measure { UserTiming.new(file_path).print }
task_timing_time = Benchmark.measure { TaskTiming.new(file_path).print }

puts '               user     system      total        real'
puts "UserTiming: #{user_timing_time}"
puts "TaskTiming: #{task_timing_time}"
