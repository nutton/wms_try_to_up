class ReceiptLine < ActiveRecord::Base

  include AASM
  

  validates	:receipt_id, :lp, :product_id, :quantity, presence: true
  validates	:quantity, :numericality => {:greater_than_or_equal_to => 1}
  validates :purchase_order_line_id, product_match: true
  validates :purchase_order_line_id, supplier_match: true
  validates :lp,  nonexisting_lp: true
  
  before_create :determine_lot

  belongs_to    :receipt
  belongs_to    :product
  belongs_to    :product_status
  belongs_to    :product_package
  belongs_to    :lot
  belongs_to    :dock_door
  belongs_to	  :purchase_order_line

aasm :column => :state, :enum => true do
  initial_state  :created
  state  :created
  state  :received
  state  :canceled


  event :start_receiving do
    transitions :to => :received, :from => [:created]
  end

  event :cancel do
    transitions :to => :canceled, :from => [:created]
  end
end

  def determine_lot
    if self.lot.nil?
      @product_warehouse_setup = ProductWarehouseSetup.where(product_id: self.product_id, warehouse_id: self.receipt.warehouse_id).first
      self.lot = @product_warehouse_setup.find_or_create_lot
    end
  end
    
  def valid_for_receiving?
    self.receipt.valid_for_receiving? and self.created?
  end
    
  def received_by_user
    User.find(self.received_by_user_id)
  end
  
  def valid_for_cancellation?
    self.created?
  end


end
