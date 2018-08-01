class AddAvatarModelToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :avatar_model, :binary
  end
end
