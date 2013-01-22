class StatisticsController < ApplicationController
  before_filter :find_user
  
  def index
    binding.pry
    if params[:query_method]
      value1 = params[:query_value_1]
      value2 = params[:query_value_2]
      
      if params[:query_method] == "month"
        @statistics = @user.statistics.find( 
          { 
            year: { value1.year }
            month: { $gte: value1.month, $lte: value2.month };
          }
        ).aggregate({
          $group:{_id:"$month", monthSize:{$sum:"$size"}}  
        })page(params[:page])
      elsif params[:query_method] == "date"
        @statistics = @user.statistics.find( 
          { 
            year: { value1.year }
            month: { value1.month };
            date: {$gte: value1.day, $lte: value2.day }
          }
        ).page(params[:page])
      end
    else
      @statistics = @user.statistics.page(params[:page])
    end
    # @category.products.where(:price.lt => 499).full_text_search('iphone').asc(:price)
    # @statistics = @user.statistics.where()
  end
  
  private
  def find_user
    @user = User.find(params[:user_id])
  end
end