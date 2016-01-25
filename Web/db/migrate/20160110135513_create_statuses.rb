class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.integer :user_id
      t.integer :temp
      t.integer :humidity
      t.date :date

      t.timestamps null: false
    end
  end
end
