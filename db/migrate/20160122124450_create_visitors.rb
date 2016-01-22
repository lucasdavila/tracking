class CreateVisitors < ActiveRecord::Migration
  def change
    create_table :visitors do |t|
      t.string :session_id
      t.string :email

      t.timestamps null: false
    end

    add_index :visitors, :session_id, unique: true
  end
end
