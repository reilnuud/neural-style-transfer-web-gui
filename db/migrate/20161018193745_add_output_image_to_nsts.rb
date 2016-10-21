class AddOutputImageToNsts < ActiveRecord::Migration[5.0]
  def change
    add_column :nsts, :outputImage, :string
  end
end
