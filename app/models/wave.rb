class Wave < ActiveRecord::Base

  include AASM
  
  aasm :column => :state, :enum => true  do
  initial_state :created
  state  :created
  state  :allocating
  state  :containerizing
  state  :completed
  end
  belongs_to  :warehouse
  has_many    :order_lines

  validates :wave_number, :state, :warehouse_id, presence: true 
  validates_uniqueness_of :wave_number, scope: :warehouse_id
  
    
  
end
