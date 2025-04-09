# db/migrate/[timestamp]_add_created_at_index_to_photos.rb
class AddCreatedAtIndexToPhotos < ActiveRecord::Migration[8.0]
  def change
    add_index :photos, :created_at, order: { created_at: :desc }
  end
end
