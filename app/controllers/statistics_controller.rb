class StatisticsController < ApplicationController
  before_filter :find_user
  
  def index
    @statistics = @user.statistics.page(params[:page])
  end
  
  private
  def find_user
    @user = User.find(params[:user_id])
  end
end