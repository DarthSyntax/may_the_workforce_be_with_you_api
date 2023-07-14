class AddJtiToEmployers < ActiveRecord::Migration[7.0]
  def change
    add_column :employers, :jti, :string
    add_index :employers, :jti, unique: true
  end
end
