# The top 10 tasks with the most extended duration

# Save the data in the parameter user_timing as a hash,
# where the key is task_id, and the value is the sum of tasks

require 'csv'

class TaskTiming
  attr_reader :file_path, :task_timing

  # Save only the top 10 tasks with the most extended duration
  def initialize(file_path)
    @file_path = file_path
    @task_timing = Hash.new(0)

    CSV.foreach(@file_path, headers: true) do |row|
      task_id = row['task_id'].to_i
      @task_timing[task_id] ||= 0
      @task_timing[task_id] += row['work_duration'].to_i
    end

    # Sort by duration and save only the top 10 tasks
    @task_timing = @task_timing.sort_by { |_task_id, duration| duration }.last(10).to_h
  end

  def print
    @task_timing.each do |task_id, duration|
      puts "Task #{task_id}: #{duration} minutes"
    end
    nil
  end
end

