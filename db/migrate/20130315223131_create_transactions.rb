class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :type
      t.integer :creditee_id 
      t.integer :debitee_id
      t.integer :amount
      t.timestamps
    end
  end
end
