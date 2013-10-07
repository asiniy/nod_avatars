class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :provider_name, null: false
      t.string :provider_uid, null: false
      t.string :username, null: false
      t.string :avatar, null: false
      t.boolean :published, null: false, default: true

      t.timestamps
    end
  end
end
