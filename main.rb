require 'benchmark'

require_relative 'lib/tasks/user_timing_task'
require_relative 'lib/tasks/task_timing_task'

file_path = 'tmp/teach_call.csv'

case ARGV[0]
when 'console'
  user_execution_time = Benchmark.measure { UserTimingTask.new(file_path).print_to_console }
  task_execution_time = Benchmark.measure { TaskTimingTask.new(file_path).print_to_console }
when 'csv'
  user_execution_time = Benchmark.measure { UserTimingTask.new(file_path).save_to_csv }
  task_execution_time = Benchmark.measure { TaskTimingTask.new(file_path).save_to_csv }
else
  puts 'Please, enter the correct command: console or csv'
  puts 'Example: ruby main.rb console'
  exit
end

puts '                  user     system      total        real'
puts "UserTimingTask: #{user_execution_time}"
puts "TaskTimingTask: #{task_execution_time}"
