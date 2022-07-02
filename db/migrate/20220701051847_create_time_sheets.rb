class CreateTimeSheets < ActiveRecord::Migration[7.0]
  def change
    create_table :time_sheets do |t|
      t.date :date
      t.time :start_time
      t.time :finish_time
      t.timestamps
    end
  end
end
