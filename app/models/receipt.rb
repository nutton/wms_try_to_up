class Receipt < ActiveRecord::Base
  
  include AASM
  
  aasm :column => :state, :enum => true do
  initial_state :created
  state :created
  state :in_receiving
  state :completed
  state :canceled
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


  validates	:estimated_receipt_date, :warehouse_id, :receipt_number, presence: true
  validates	:receipt_number, uniqueness: true
  
  belongs_to    :warehouse
  belongs_to    :supplier
  belongs_to	:receipt_type
  
  has_many      :receipt_lines
  

  
  
  
  def total_quantity
    @total_quantity =  0
    self.receipt_lines.each do |receipt_line|
      @total_quantity += receipt_line.quantity
    end
    @total_quantity
  end
  
  def received_quantity
    @received_quantity = 0
    self.receipt_lines.each do |receipt_line|
      @received_quantity += receipt_line.quantity if receipt_line.received?
    end
    @received_quantity
  end
  
  def valid_for_receiving?
    (self.receipt.in_receiving? or self.receipt.created?) 
  end
 
end
