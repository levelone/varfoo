class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
    	t.references :article
      t.string :image_url
      t.timestamps
    end
  end
end