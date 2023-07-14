class AddEmployerRefToJobs < ActiveRecord::Migration[7.0]
  def change
    add_reference :jobs, :employer, foreign_key: true
  end
end
