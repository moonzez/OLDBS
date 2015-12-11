class ErrorsController < ApplicationController
  def index
    puts "HAH"
    puts request.remote_ip
    puts "KJKJ"
    render :nothing => true
  end
end
