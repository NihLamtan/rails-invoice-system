class ReportsController < ApplicationController


  def create
     @report = Report.new(report_param)
     @report.save
     
  end
  
  
  private
 
  def report_param
    params.require(:report).permit(:start_date, :end_date)
  end
  
 
end
