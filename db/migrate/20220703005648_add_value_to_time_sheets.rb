class AddValueToTimeSheets < ActiveRecord::Migration[7.0]
  def change
    add_column :time_sheets, :value, :float
  end
end
