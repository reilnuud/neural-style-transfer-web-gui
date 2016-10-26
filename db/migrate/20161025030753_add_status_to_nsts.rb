class AddStatusToNsts < ActiveRecord::Migration[5.0]
  def change
    add_column :nsts, :status, :string
  end
end
