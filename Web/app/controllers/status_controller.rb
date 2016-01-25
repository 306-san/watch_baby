class StatusController < ApplicationController
  def create
    @status = Status.create(user_id: params[:user_id], temp: params[:temp], humidity: params[:humidity] , date:Time.now)
   end
end
