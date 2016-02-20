class Shipment < ActiveRecord::Base


  has_many	:shipment_contents
  belongs_to	:warehouse
  belongs_to	:dock_door
  

  include AASM

  aasm :column => :state, :enum => true do
  initial_state :created
  state  :created
  state :arrived
  state :departed
  state :canceled


  event :arrive do
    transitions :to => :arrived, :from => [:created]
  end

  event :depart do
    transitions :to => :departed, :from => [:arrived]
  end

  event :cancel do
    transitions :to => :canceled, :from => [:created]
  end
end





end
