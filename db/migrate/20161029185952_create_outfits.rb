class CreateOutfits < ActiveRecord::Migration[5.0]
  def change
    create_table :outfit_element_types do |t|
      t.string :name, null: false
      t.string :symbol, index: { unique: true }, null: false
      t.integer :sex, null: false
      t.integer :position, null: false

      t.timestamps null: false
    end
    add_index :outfit_element_types, [:sex, :position], unique: true

    create_table :outfit_categories do |t|
      t.integer :parent_id
      t.references :outfit_element_type, index: true, foreign_key: true, null: true
      t.string :name, null: false
      t.string :symbol, null: false
      t.string :full_symbol
      t.boolean :last_category, default: false
      t.boolean :re_hire, default: false

      t.timestamps null: false
    end
    add_index :outfit_categories, :parent_id
    add_index :outfit_categories, [:parent_id, :symbol], unique: true
    add_foreign_key :outfit_categories, :outfit_categories, column: :parent_id

    create_table :outfit_elements do |t|
      t.references :outfit_category, index: true, foreign_key: true
      t.string :symbol
      t.string :full_symbol
      t.string :awf_code
      t.boolean :rented, default: false

      t.timestamps null: false
    end
    add_index :outfit_elements, [:outfit_category_id, :symbol], unique: true
  end
end
