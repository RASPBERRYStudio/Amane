class AddAmaneWorldTable < ActiveRecord::Migration[5.2]
  def change
    create_table :world do |t|
      t.integer :dx
      t.integer :dy
      t.integer :dz
      t.json :blocks, array: true
    end
  end
end
