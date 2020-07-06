class AddColumnToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :Products, :jan_code, :string
    add_column :Products, :shipping_location, :string
    add_column :Products, :notification_email, :string
    add_column :Products, :new_flg, :boolean, default: true, null: false
    add_column :Products, :popular_flg, :boolean, default: true, null: false
    add_column :Products, :comment, :text
    add_column :Products, :explanation_1, :text
    add_column :Products, :explanation_2, :text
    add_column :Products, :tax_flg, :boolean, default: true, null: false
    add_column :Products, :manufacturer, :string
    add_column :Products, :remote_island_shipping_confirmation, :boolean, default: true, null: false
    add_column :Products, :display_period_start, :date
    add_column :Products, :display_period_end, :date
    add_column :Products, :purchase_limit, :integer
    add_column :Products, :postage_comment, :text
  end
end
