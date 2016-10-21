class AddIterationsToNsts < ActiveRecord::Migration[5.0]
  def change
    add_column :nsts, :iterations, :integer
  end
end
