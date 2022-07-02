class TimeSheetsController < ApplicationController
  def index
    @entries = TimeSheet.all
  end

  def new
    @entry = TimeSheet.new
  end

  def create
    @entry = TimeSheet.new(time_sheet_params)

    if @entry.save
      redirect_to time_sheets_path, status: :created
    else
      render :new, status: :bad_request
    end
  end

  def destroy
    @entry = TimeSheet.find(params[:id])
    @entry.destroy

    redirect_to time_sheets_path, status: :see_other
  end

  private

  def time_sheet_params
    params.require(:time_sheet).permit(:date, :start_time, :finish_time)
  end
end
