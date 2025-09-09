class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.integer :order
      t.integer :project_id

      t.timestamps
    end
  end
end
