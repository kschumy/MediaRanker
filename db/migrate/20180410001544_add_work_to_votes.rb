class AddWorkToVotes < ActiveRecord::Migration[5.1]
  def change
    add_reference :votes, :work, foreign_key: true
  end
end
