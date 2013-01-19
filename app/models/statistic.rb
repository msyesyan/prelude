class Statistic
  include Mongoid::Document
  belongs_to :user
  field :year, type: Integer
  field :month, type: Integer
  field :size, type: Integer

  def self.add_statistic
    User.each do |user|
      statistic = user.find_or_initial_this_month_statistic do |statistic|
        statistic.user = user
        statistic.size = user.this_moth_total_size
        statistic.year = Time.now.year
        statistic.month = Time.now.month
      end
      statistic.save
    end
  end
end