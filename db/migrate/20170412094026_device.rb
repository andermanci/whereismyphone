
  class Device < ActiveRecord::Migration[5.0]
    def change
      create_table :device do |t|
        t.column :ip, :string
        t.column :name, :string
        t.column :info, :string
      end
    end
  end


