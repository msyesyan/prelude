#encoding: utf-8
namespace :app do

  desc "add cdrs and mount statistic every 1 minute"
  task :add_cdr_and_mount_statics => :environment do
    begin
      Cdr.add_cdr
      Statistic.add_statistic
    rescue Exception => e
      Rails.logger.error "upload error: #{e.to_s}"
    end
  end
  
end
