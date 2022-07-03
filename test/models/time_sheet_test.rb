require 'test_helper'

class TimeSheetTest < ActiveSupport::TestCase
  start_time = Time.parse('10:00')
  finish_time = Time.parse('11:00')
  today = Date.today
  yesterday = Date.yesterday
  tomorrow = Date.tomorrow

  test 'should not save entry without date' do
    entry = TimeSheet.new(start_time: start_time, finish_time: finish_time)
    assert_not entry.save, 'Save timesheet entry without date'
  end

  test 'should not save entry without start time' do
    entry = TimeSheet.new(finish_time: finish_time, date: yesterday)
    assert_not entry.save, 'Save timesheet entry without start time'
  end

  test 'should not save entry without finish time' do
    entry = TimeSheet.new(start_time: start_time, date: yesterday)
    assert_not entry.save, 'Save timesheet entry without finish time'
  end

  test 'should not save entry without date, start time and finish time' do
    entry = TimeSheet.new
    assert_not entry.save, 'Save timesheet entry without date, start time and finish time'
  end

  test 'should save entry with date in the past' do
    entry = TimeSheet.new(date: yesterday, start_time: start_time, finish_time: finish_time)
    assert entry.save, 'Save timesheet with past date successfully'
  end

  test 'should save entry with current date' do
    entry = TimeSheet.new(date: today, start_time: start_time, finish_time: finish_time)
    assert entry.save, 'Save timesheet with current date successfully'
  end

  test 'should not save entry with date in the future' do
    entry = TimeSheet.new(date: tomorrow, start_time: start_time, finish_time: finish_time)
    assert_not entry.save, 'Save timesheet entry without date: tomorrow'
  end

  test 'should not save entry with finish time < start time' do
    entry = TimeSheet.new(date: tomorrow, start_time: finish_time, finish_time: start_time)
    assert_not entry.save, 'Save timesheet entry without date: tomorrow'
  end

  test 'should not save entry with overlapping entries 1' do
    entry = TimeSheet.new(date: today, start_time: '09:00', finish_time: '12:00')
    entry.save
    another_entry = TimeSheet.new(date: today, start_time: '10:00', finish_time: '11:00')
    assert_not another_entry.save
  end

  test 'should not save entry with overlapping entries 2' do
    entry = TimeSheet.new(date: today, start_time: '09:00', finish_time: '12:00')
    entry.save
    another_entry = TimeSheet.new(date: today, start_time: '10:00', finish_time: '13:00')
    assert_not another_entry.save
  end

  test 'should not save entry with overlapping entries 3' do
    entry = TimeSheet.new(date: today, start_time: '09:00', finish_time: '12:00')
    entry.save
    another_entry = TimeSheet.new(date: today, start_time: '08:00', finish_time: '10:00')
    assert_not another_entry.save
  end

  test 'should not save entry with overlapping entries 4' do
    entry = TimeSheet.new(date: today, start_time: '09:00', finish_time: '12:00')
    entry.save
    another_entry = TimeSheet.new(date: today, start_time: '08:00', finish_time: '13:00')
    assert_not another_entry.save
  end
end
