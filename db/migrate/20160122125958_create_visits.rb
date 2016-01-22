class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.references :visitor, index: true, foreign_key: true
      t.string :url, index: true
      t.datetime :datetime

      t.timestamps null: false
    end
  end
end
