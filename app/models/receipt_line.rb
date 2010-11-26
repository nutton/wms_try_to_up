class ReceiptLine < ActiveRecord::Base

  validates	:receipt_id, :lp, :product_id, :quantity, :presence => true
  validates	:quantity, :numericality => {:greater_than_or_equal_to => 1}

  before_create :determine_lot

  belongs_to    :receipt
  belongs_to    :product
  belongs_to    :product_status
  belongs_to    :product_package
  belongs_to    :lot


  state :created
  state :received
  state :cancelled

  event :start_receiving do
    transitions :from => :created, :to => :received
  end

  event :cancel do
    transitions :from => :created, :to => :cancelled
  end


  def determine_lot
    if self.lot.nil?
      @product_warehouse_setup = ProductWarehouseSetup.where(:product_id => self.product_id, :warehouse_id => self.receipt.warehouse_id).first
      self.lot = @product_warehouse_setup.find_or_create_lot
    end
  end
  

end
