class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.references :user
      t.string :title
      t.string :content

      t.timestamps
    end
  end

  def self.up
	  change_column :articles, :content, :string, :limit => nil
	end
end
