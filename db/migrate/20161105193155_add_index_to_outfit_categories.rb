class AddIndexToOutfitCategories < ActiveRecord::Migration[5.0]
  def change
    add_index :outfit_categories, :symbol, unique: true, where: 'parent_id is null'
  end
end
