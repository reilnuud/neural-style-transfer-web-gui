class ChangeRatioToFloat < ActiveRecord::Migration[5.0]
  def change
  	change_column :nsts, :styleRatio, :float
  end
end
