class RenameColumnInTableName < ActiveRecord::Migration[7.0]
  def change
    rename_column :employers, :employer_email, :email
  end
end
