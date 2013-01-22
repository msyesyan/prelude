class Statistic
  include Mongoid::Document
  include Mongoid::Search

  belongs_to :user

  field :year, type: Integer
  field :month, type: Integer
  field :day, type: Integer
  field :size, type: Integer
  
  def self.add_statistic
    User.each do |user|
      statistic = user.find_or_initial_day_statistic do |statistic|
        statistic.user = user
        statistic.size = user.day_to_now_size
        statistic.day = Time.now.day
        statistic.month = Time.now.month
        statistic.year = Time.now.year
      end
      statistic.save
    end
  end
end