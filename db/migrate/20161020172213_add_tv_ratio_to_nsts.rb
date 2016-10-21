class AddTvRatioToNsts < ActiveRecord::Migration[5.0]
  def change
    add_column :nsts, :tvRatio, :float
  end
end
