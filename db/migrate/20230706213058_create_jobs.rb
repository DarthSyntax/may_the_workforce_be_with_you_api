class CreateJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :description
      t.integer :salary
      t.string :exp_level

      t.timestamps
    end
  end
end
