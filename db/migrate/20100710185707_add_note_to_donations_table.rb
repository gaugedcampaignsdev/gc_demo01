class AddNoteToDonationsTable < ActiveRecord::Migration
  def self.up
    add_column :donations, :note, :text
  end

  def self.down
    remove_column :donations, :note
  end
end
