class User
  include Mongoid::Document
  
  ROLES = %w[admin banned]

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              :type => String, :default => ""
  field :login,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""
  
  field :role, :type => String, :default => "banned"
  field :domain, :type => String, :default => ""
  field :portal, :type => Integer, :default => ""
  
  validates :login, :portal, :uniqueness => true
   
  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String
  has_many :cdrs
  has_many :statistics
  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String
  
  after_create do |user|
    user.domain = "#{user.login}.p.wido.me"
    user.portal = rand(10000) + 20000
    user.save
  end
  
  def total_size
    self.cdrs.map(&:size).inject(&:+)
  end
  
  def find_or_initial_this_month_statistic(&block)
    statistic = self.statistics.where(:year => Time.now.year, :month => Time.now.month).first || self.statistics.new
    yield(statistic) if block
    statistic
  end
  
  def find_all_this_month_cdrs
    cdrs = self.cdrs.where(:created_at => Time.now.beginning_of_month..Time.now.end_of_month.end_of_day).all
  end
  
  def this_moth_total_size
    cdrs = self.find_all_this_month_cdrs
    size = cdrs.map(&:size).inject(&:+)
  end
  
end
