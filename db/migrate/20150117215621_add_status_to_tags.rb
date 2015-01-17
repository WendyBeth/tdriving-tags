class AddStatusToTags < ActiveRecord::Migration
  def change
    add_column :tags, :status, :string, default: "pending"
  end
end
