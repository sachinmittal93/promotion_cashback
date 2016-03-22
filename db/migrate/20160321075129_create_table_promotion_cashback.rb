class CreateTablePromotionCashback < ActiveRecord::Migration
  def change
    create_table :spree_promotion_cashbacks do |t|
      t.belongs_to :order, index: true
      t.references :promotion_action, polymorphic: true
      t.timestamps null: false
    end
  end
end
