class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  
  before_filter :authorize, :authorize_read_only
  protect_from_forgery
  
  def report_logger(id)
    @report_loggers = {} unless @report_loggers
    return @report_loggers[id] if @report_loggers[id]
    report_file_path = "#{Rails.root}/log/report/taskboard_#{id}.log"
    report_file = File.open(report_file_path, 'a') 
    report_file.sync = true
    @report_loggers[id] = Logger.new(report_file)
  end

  private
  def authorize
    session[:original_uri] = request.fullpath unless request.xhr?
    if session[:user_id].nil?
      redirect_to(:controller => 'login', :action => 'login')
    end
  end

  def authorize_read_only
    session[:original_uri] = request.fullpath unless request.xhr?
    unless session[:user_id].nil?
      unless session[:editor]
        flash[:notice] = "You do not have permission to do that!"
        redirect_to(:controller => 'taskboard', :action => 'index')
      end
    end
  end
end
