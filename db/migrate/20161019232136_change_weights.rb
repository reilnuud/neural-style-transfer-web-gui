class ChangeWeights < ActiveRecord::Migration[5.0]
  def change
  	change_column :nsts, :styleWeight, :float
  	change_column :nsts, :contentWeight, :float
  end
end
