class CreateMemberRanks < ActiveRecord::Migration[5.2]
  def change
    create_table :member_ranks do |t|
      t.string :name
      t.integer :multiplication_rate
      t.integer :recalculation
      t.timestamps
    end
  end
end
