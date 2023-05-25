# CSV file with 500 000 rows and containing new columns:
# - user_id (int)
# - task_id (int)
# - work_duration (int)
# - date (timestamp)
# - comment (text 255)

# users count: 20, tasks count: 100

require 'csv'
require 'faker'

# Generate CSV file with random data
class CsvGenerator
  ROWS_COUNT = 500_000.freeze
  USER_IDS_RANGE = (1..20).freeze
  TASK_IDS_RANGE = (1..100).freeze
  WORK_DURATION_RANGE = (1..60).freeze

  attr_reader :file_path

  def initialize(file_path)
    @file_path = file_path
  end

  def call
    CSV.open(file_path, 'w') do |csv|
      csv << %w[user_id task_id work_duration date comment]
      ROWS_COUNT.times do
        csv << [
          Faker::Number.within(range: USER_IDS_RANGE),
          Faker::Number.within(range: TASK_IDS_RANGE),
          Faker::Number.within(range: WORK_DURATION_RANGE),
          Faker::Time.backward(days: 1),
          Faker::Lorem.sentence
        ]
      end
    end
  end
end
