class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.date :buyday
      t.string :title
      t.integer :dollar
      t.text :description

      t.timestamps null: false
    end
  end
end
