class CreateDevices < ActiveRecord::Migration[5.0]
  def change
    create_table(:devices) do |t|
      t.references :user
      t.column :token, :string
      t.column :name, :string
      t.column :info, :string
    end
  end
end
