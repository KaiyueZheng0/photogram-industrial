class CreateFollowRequests < ActiveRecord::Migration[8.0]
  def change
    create_table :follow_requests do |t|
      t.references :sender, null: false, foreign_key: { to_table: :users }
      t.references :recipient, null: false, foreign_key: { to_table: :users }
      t.string :status, null: false, default: "pending"

      t.timestamps
    end

    add_index :follow_requests, [:sender_id, :recipient_id], unique: true
  end
end
