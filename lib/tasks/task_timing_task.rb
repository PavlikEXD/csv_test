# The top 10 tasks with the most extended duration

# Save the data in the parameter user_timing as a hash,
# where the key is task_id, and the value is the sum of tasks

require 'csv'

class TaskTimingTask
  def initialize(file_path)
    # Read the CSV file and save the data in the task_timing hash
    @task_timing = Hash.new(0)

    CSV.foreach(file_path, headers: true) do |row|
      task_id = row['task_id'].to_i
      work_duration = row['work_duration'].to_i

      @task_timing[task_id] += work_duration
    end

    # Sort by duration and save only the top 10 tasks
    @task_timing = @task_timing.sort_by { |_task_id, duration| duration }.last(10).to_h
  end

  def print_to_console
    @task_timing.each do |task_id, duration|
      puts "Task #{task_id}: #{duration} minutes"
    end
  end

  def save_to_csv(file_path: 'tmp/task_timing.csv')
    CSV.open(file_path, 'w') do |csv|
      csv << %w[task_id work_duration]
      @task_timing.each do |(task_id, work_duration), index|
        csv << [index, task_id, work_duration]
      end
    end
  end
end
