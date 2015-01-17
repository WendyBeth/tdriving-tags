class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.text :abstract
      t.string :youtube_code

      t.timestamps
    end
  end
end
