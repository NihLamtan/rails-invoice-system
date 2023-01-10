class InvoicesexcelController < ApplicationController
#    before_action :set_date_params
   respond_to :html, :xlsx, :ods, :csv

      
    def index 
        @invoicesexcel = Invoicesexcel.new(date_params)
        @invoicesexcel.save
        @items = Invoice.where("created_at IN (?)",(date_params[:start_date].to_date)..(date_params[:end_date].to_date))
       render xlsx: @items
    end
  
    

   

  end
  