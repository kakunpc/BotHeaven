class CreateStorages < ActiveRecord::Migration[4.2]
  def change
    create_table :storages do |t|
      t.references :bot, index: true
      t.text :content

      t.timestamps null: false
    end
    add_foreign_key :storages, :bots
  end
end
