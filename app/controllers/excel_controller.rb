class ExcelController < ApplicationController
  respond_to :html, :xlsx, :ods, :csv
    
  def index
   @items = Client.all
     render xlsx: @items
  end
end
