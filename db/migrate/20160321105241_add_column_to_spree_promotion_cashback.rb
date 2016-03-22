class AddColumnToSpreePromotionCashback < ActiveRecord::Migration
  def change
    add_column :spree_promotion_cashbacks, :state, :string, default: 'pending'
  end
end
