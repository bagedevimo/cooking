class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.belongs_to :user
      t.text :name, null: false
      t.text :description, null: false
      t.text :directions, null: false
      t.timestamps
    end

    add_index :recipes, [:user_id, :name], unique: true
  end
end
