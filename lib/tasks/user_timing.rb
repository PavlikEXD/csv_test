# How much time did each user spend on each task?
# What if we have a lot of tasks?

# Save the data in the parameter user_timing as a hash,
# where the key is user_id, and the value is a hash,
# where the key is task_id, and the value is the sum of tasks

require 'csv'

class UserTiming
  attr_reader :file_path, :user_timing

  def initialize(file_path)
    @file_path = file_path
    @user_timing = {}

    CSV.foreach(@file_path, headers: true) do |row|
      user_id = row['user_id'].to_i
      task_id = row['task_id'].to_i
      work_duration = row['work_duration'].to_i
      @user_timing[user_id] ||= Hash.new(0)
      @user_timing[user_id][task_id] += work_duration
    end
  end

  # If top is nil, then print all tasks,
  # otherwise print top tasks
  def print
    @user_timing.each do |user_id, task_hash|
      puts "User #{user_id}:"
      task_hash.each do |task_id, duration|
        puts "  Task #{task_id}: #{duration} minutes"
      end
    end
    nil
  end
end

