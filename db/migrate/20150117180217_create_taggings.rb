class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.integer :video_id
      t.integer :tag_id

      t.timestamps
    end

    add_index :taggings, :video_id
    add_index :taggings, :tag_id
    add_index :taggings, [:video_id, :tag_id], unique: true
  end
end
