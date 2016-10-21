class CreateNsts < ActiveRecord::Migration[5.0]
  def change
    create_table :nsts do |t|
      t.string :styleImage
      t.integer :styleWeight
      t.string :contentImage
      t.integer :contentWeight
      t.integer :styleRatio
      t.integer :imageSize
      t.boolean :originalColors
      t.string :initPattern
      t.string :pooling

      t.timestamps
    end
  end
end
