class AddColumnToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :jan_code, :string
    add_column :products, :shipping_location, :string
    add_column :products, :notification_email, :string
    add_column :products, :new_flg, :boolean, default: true, null: false
    add_column :products, :popular_flg, :boolean, default: true, null: false
    add_column :products, :comment, :text
    add_column :products, :explanation_1, :text
    add_column :products, :explanation_2, :text
    add_column :products, :tax_flg, :boolean, default: true, null: false
    add_column :products, :manufacturer, :string
    add_column :products, :remote_island_shipping_confirmation, :boolean, default: true, null: false
    add_column :products, :display_period_start, :date
    add_column :products, :display_period_end, :date
    add_column :products, :purchase_limit, :integer
    add_column :products, :postage_comment, :text
  end
end
