class PurchaseOrder < ActiveRecord::Base

  include AASM

  aasm :column => :state, :enum => true do
  
  initial_state :created
  state :canceled
  state :created
  state :in_receiving
  state :completed

  event :start_receiving do
    transitions :to => :in_receiving, :from => [:created]
  end

  event :complete_receiving do
    transitions :to => :completed, :from => [:created,:in_receiving]
  end

  event :cancel do
    transitions :to => :canceled, :from => [:created]
  end

  end

  validates	:purchase_order_number, :company_id, presence: true
  validates	:purchase_order_number, uniqueness: true
  
  belongs_to    :supplier
  belongs_to    :purchase_order_type
  belongs_to    :company

  has_many      :purchase_order_lines
  
  

  def editable?
    self.state == 'created'
  end

  def total_quantity
    ordered_quantity = 0
    self.purchase_order_lines.each do |purchase_order_line|
      ordered_quantity += purchase_order_line.quantity
    end
    ordered_quantity
  end
 
  def received_quantity
	@received_quantity = 0
	#first adding receipt lines against self
	self.receipt_lines.each do |receipt_line|
		@received_quantity += receipt_line.quantity	
	end
	@received_quantity
  end 

end
