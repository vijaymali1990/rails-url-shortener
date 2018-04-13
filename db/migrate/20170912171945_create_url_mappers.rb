class CreateUrlMappers < ActiveRecord::Migration[5.1]
  def change
    create_table :url_mappers do |t|
      t.string :alias
      t.string :domain
      t.text :original_url
      t.string :short_url
      t.integer :search_count, default: 0

      t.timestamps
    end
  end
end
