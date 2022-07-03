class TimeSheetsController < ApplicationController
  def index
    @entries = TimeSheet.all
  end

  def new
    @entry = TimeSheet.new
  end

  def create
    @entry = TimeSheet.new
    @entry.start_time = Time.find_zone('UTC').parse(time_sheet_params[:start_time])
    @entry.finish_time = Time.find_zone('UTC').parse(time_sheet_params[:finish_time])
    @entry.date = time_sheet_params[:date]

    total_hours = @entry.total_hours
    case @entry.date.strftime('%a')
    when 'Mon', 'Wed', 'Fri'
      regular_start_time = Time.find_zone('UTC').parse('07:00')
      regular_end_time   = Time.find_zone('UTC').parse('19:00')
      regular_hours      = [@entry.regular_hours(regular_start_time, regular_end_time), 0].max
      ot_hours           = [total_hours - regular_hours, 0].max
      @entry.value       = regular_hours * 22 + ot_hours * 34
    when 'Tue', 'Thu'
      regular_start_time = Time.find_zone('UTC').parse('05:00')
      regular_end_time   = Time.find_zone('UTC').parse('17:00')
      regular_hours      = [@entry.regular_hours(regular_start_time, regular_end_time), 0].max
      ot_hours = [total_hours - regular_hours, 0].max
      @entry.value = regular_hours * 25 + ot_hours * 35
    else
      @entry.value = total_hours * 47
    end

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
