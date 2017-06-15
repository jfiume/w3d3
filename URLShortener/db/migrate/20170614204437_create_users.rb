class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.timestamps
      t.string :email, null: false


    end
    add_index :users, :email, unique: true #hopefully users is not capitalized
  end
end
