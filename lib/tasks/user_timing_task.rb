# How much time did each user spend on each task?
# What if we have a lot of tasks?

# Save the data in the parameter user_timing as a hash,
# where the key is user_id, and the value is a hash,
# where the key is task_id, and the value is the sum of tasks

require 'csv'

class UserTimingTask
  def initialize(file_path)
    # Read the CSV file and save the data in the user_timing hash
    @user_timing = {}

    CSV.foreach(file_path, headers: true) do |row|
      user_id = row['user_id'].to_i
      task_id = row['task_id'].to_i
      work_duration = row['work_duration'].to_i

      @user_timing[user_id] ||= Hash.new(0)
      @user_timing[user_id][task_id] += work_duration
    end
  end

  def print_to_console
    @user_timing.each do |user_id, task_hash|
      puts "User #{user_id}:"
      # Print task information like this:
      # Task 1: 100 minutes | Task 2: 200 minutes | Task 3: 300 minutes
      puts task_hash.map { |task_id, work_duration| "Task #{task_id}: #{work_duration} minutes" }.join(' | ')
      puts
    end
  end

  def save_to_csv(file_path: 'tmp/user_timing.csv')
    CSV.open(file_path, 'w') do |csv|
      csv << %w[user_id task_id work_duration]

      @user_timing.each do |user_id, task_hash|
        csv << [user_id]

        task_hash.each do |task_id, work_duration|
          csv << [nil, task_id, work_duration]
        end
      end
    end
  end
end
