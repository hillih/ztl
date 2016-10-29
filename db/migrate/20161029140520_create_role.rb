class CreateRole < ActiveRecord::Migration[5.0]
  def change
    create_table :roles do |t|
      t.string :name, null: false
      t.string :symbol, index: { unique: true }
      t.text :permissions, array: true, default: []
      t.timestamps null: false
    end

    add_reference :users, :role, index: true, foreign_key: true
  end
end
