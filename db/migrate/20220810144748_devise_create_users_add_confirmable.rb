class DeviseCreateUsersAddConfirmable < ActiveRecord::Migration[6.1]
  def change
    add_column :t.string   :confirmation_token
    add_column  :t.datetime :confirmed_at
    add_column :t.datetime :confirmation_sent_at
      add_column :t.string   :unconfirmed_email
  end
end
