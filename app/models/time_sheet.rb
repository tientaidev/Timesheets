# frozen_string_literal: true

class TimeSheet < ApplicationRecord
  validates :date, presence: { message: 'is required' }
  validates :date, comparison: { less_than_or_equal_to: Date.today, message: 'cant be in the future' }
  validates :start_time, presence: { message: 'is required' }
  validates :finish_time, presence: { message: 'is required' }
  validates :finish_time, comparison: { greater_than: :start_time, message: 'must be greater than Start time' }
  validate :validate_other_time_overlap

  def period
    start_time..finish_time
  end

  private

  def validate_other_time_overlap
    other_times = TimeSheet.all
    is_overlapping = other_times.any? do |other_time|
      period.overlaps?(other_time.period)
    end

    errors.add :base, :invalid, message: 'You cant have overlapping timesheet entries.' if is_overlapping
  end
end
