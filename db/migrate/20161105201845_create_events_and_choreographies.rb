class CreateEventsAndChoreographies < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.date :start_at, null: false
      t.date :end_at
      t.boolean :division, default: true

      t.timestamps null: false
    end

    create_table :choreographies do |t|
      t.references :event, index: true, foreign_key: true, null: false
      t.references :outfit_category, index: true, foreign_key: true, null: true
      t.string :name
      t.boolean :artificial, default: false

      t.timestamps null: false
    end
    add_index :choreographies, [:event_id, :outfit_category_id], unique: true, where: 'outfit_category_id is not null'
    add_index :choreographies, [:event_id, :artificial], unique: true, where: 'outfit_category_id is null'

    create_table :choreography_settings do |t|
      t.references :outfit_element_type, index: true, foreign_key: true, null: false
      t.references :outfit_category, index: true, foreign_key: true, null: true
      t.references :choreography, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
    add_index :choreography_settings,
              [:outfit_element_type_id, :outfit_category_id, :choreography_id],
              name: 'index_choreography_settings_on_id',
              unique: true
  end
end
