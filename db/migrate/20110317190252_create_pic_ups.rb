class CreatePicUps < ActiveRecord::Migration
  #NOTE: Borrar la tabla PluginSchemaInfo el registro de la migrate para poder lanzarla de nuevo
  def self.up
    create_table :pic_ups, :force => true do |t|
      t.column "project_id", :string, :limit => 30, :null => false
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

