class AddLearnRateToNsts < ActiveRecord::Migration[5.0]
  def change
    add_column :nsts, :learnRate, :float
  end
end
