class CreateTimeSheets < ActiveRecord::Migration[7.0]
  def change
    create_table :time_sheets do |t|
      t.date :date
      t.datetime :start_time
      t.datetime :finish_time
      t.timestamps
    end
  end
end
