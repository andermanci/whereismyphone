class RenameLocalizationToLocation < ActiveRecord::Migration[5.0]
  def change
    rename_table :localizations, :locations
  end
end
