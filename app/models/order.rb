class Order < ActiveRecord::Base


  include AASM
  
  aasm :column => :state, :enum => true do
    initial_state :created
    state  :created
    state  :allocated
    state  :picked
    state  :staged
    state  :loaded
    state  :shipped  
    state  :cancelled
  
  
  event :allocate do
    transitions :to => :allocated, :from => [:created]
  end

  event :pick do
    transitions :to => :picked, :from => [:allocated]
  end  

  event :stage do
    transitions :to => :staged, :from => [:picked]
  end
  
  event :load do
    transitions :to => :loaded, :from => [:staged]
  end
  
  event :ship do
    transitions :to => :loaded, :from => [:shipped]
  end
  
  event :cancel do
    transitions :to => :cancelled, :from => [:created]
  end
  end 

  validates	:order_number, :ship_date, :customer_id, :received_date, :ship_addres_1, :ship_city, :ship_country_id, :company_id, presence: true
  validates	:order_number, :uniqueness => true

  belongs_to	:company
  belongs_to	:customer
  belongs_to	:order_type
  
  has_many	:order_lines, :dependent => :destroy  

  has_many	:shipment_contents, :as => :content

  accepts_nested_attributes_for :order_lines
  
  def ship_country
    @ship_country = Country.find(self.ship_country_id)
  end
  
  def self.states
    @@states = []
    Order.aasm_states.each {|state| @@states << state.name.to_s }
    @@states
  end
  
  def full_shipping_address
    @full_shipping_address = self.ship_addres_1 + ", "
    @full_shipping_address += self.ship_address_2 unless self.ship_address_2.nil?
    @full_shipping_address += self.ship_city + ", " + self.ship_state + ", " + self.ship_postal_code + ", " + self.ship_country.name
  end
  
  def editable?
    self.created?
  end

end
