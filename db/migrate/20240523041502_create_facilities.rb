class CreateFacilities < ActiveRecord::Migration[7.1]
  def change
    create_table :facilities do |t|
      t.string :name
      t.text :description
      t.string :location
      t.string :pincode
      t.string :sport

      t.timestamps
    end
  end
end
