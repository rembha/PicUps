class CreatePicUps < ActiveRecord::Migration
  def self.up
    create_table :pic_ups do |t|
      t.column "project_id", :string, :limit => 30, :default => "", :null => false
      t.column "activated", :boolean, :default => false, :null => false
      t.column "day",:integer, :default => 0, :null => false
      t.column "num_day",:integer, :default => 0, :null => false
      t.column "description",:text
    end
  end

  def self.down
    drop_table :pic_ups
  end
end

