require 'test_helper'

class TimeSheetsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @entry = time_sheets(:one)
  end

  teardown do
    Rails.cache.clear
  end

  test 'should get index' do
    get time_sheets_url
    assert_response :success
  end

  test 'should create timesheet entry' do
    assert_difference('TimeSheet.count') do
      post time_sheets_url,
           params: { time_sheet: { date: '2019-04-15', start_time: '10:00', finish_time: '17:00' } }
    end
  end

  test 'should calculate entry correctly' do
    assert_difference('TimeSheet.count') do
      post time_sheets_url,
           params: { time_sheet: { date: '2019-04-15', start_time: '10:00', finish_time: '17:00' } }
    end
  end

  test 'should delete timesheet entry' do
    assert_difference('TimeSheet.count', -1) do
      delete time_sheet_url(@entry)
    end
  end
end
