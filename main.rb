require 'benchmark'

require_relative 'lib/tasks/user_timing_task'
require_relative 'lib/tasks/task_timing_task'

file_path = 'tmp/teach_call.csv'

user_execution_time = Benchmark.measure { UserTimingTask.call(file_path)  }
task_execution_time = Benchmark.measure { TaskTimingTask.call(file_path)}

puts '                  user     system      total        real'
puts "UserTimingTask: #{user_execution_time}"
puts "TaskTimingTask: #{task_execution_time}"
