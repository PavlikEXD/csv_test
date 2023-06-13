require 'benchmark'

require_relative 'lib/tasks/user_timing_task'
require_relative 'lib/tasks/task_timing_task'

file_path = 'tmp/data.csv'

def measure_time_and_memory
  memory_before = `ps -o rss= -p #{Process.pid}`.to_i / 1024 # Memory in MB
  time_start = Process.clock_gettime(Process::CLOCK_MONOTONIC)

  yield

  time_end = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  memory_after = `ps -o rss= -p #{Process.pid}`.to_i / 1024 # Memory in MB

  # Execution time in seconds
  execution_time = time_end - time_start
  # Memory usage in MB
  memory_usage = memory_after - memory_before

  # puts "Execution time: #{execution_time.round(4)} seconds"
  # puts "Memory usage: #{memory_usage} MB"

  [execution_time, memory_usage]
end

# Check the execution time and memory usage of the UserTiming and TaskTiming class
# using the measure_time_and_memory method

user_execution_time, user_memory_usage = measure_time_and_memory do
  UserTimingTask.call(file_path)
end

task_execution_time, task_memory_usage = measure_time_and_memory do
  TaskTimingTask.call(file_path)
end

puts
puts 'UserTimingTask'
puts "Execution time: #{user_execution_time.round(4)} seconds"
puts "Memory usage: #{user_memory_usage} MB"
puts
puts 'TaskTimingTask'
puts "Execution time: #{task_execution_time.round(4)} seconds"
puts "Memory usage: #{task_memory_usage} MB"
