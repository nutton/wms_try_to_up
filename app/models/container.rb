class Container < ActiveRecord::Base

  include AASM
  
  aasm :column => :state, :enum => true do
    initial_state :created
    state  :created
    state :allocated
    state :picked
    state :staged
    state :loaded
    state :shipped  
    state :closed
  end

  belongs_to	:container_location,  polymorphic: true
  belongs_to 	:container_type
  has_many	  :container_contents
  has_many	  :container_contents, dependent: :destroy

  acts_as_tree :foreign_key => 'parent_container_id'


  
  validates	:lp, :uniqueness => true
  validates	:lp, :container_location, :presence => true


  def self.location_types
	  @location_types = ["DockDoor","Location","User","Shipment"]
	  @location_types
  end


  def single_product?
  	 products.count == 1
  end
  
  def products
  	  @products = []
  	  self.container_contents.each do |container_content|
  	  	  @products << container_content.product unless @products.include?(container_content.product) || container_content.product.nil?
  	  end
  	  children.each do |child_container|
  	  	  @products << child_container.products
  	  end
  	  @products.flatten!
  	  @products.uniq!
  	  @products
  end
  

  def receipt_types
    @receipt_types = []
    self.container_contents.each do |container_content|
      unless container_content.receipt_line.nil?
        @receipt_types << container_content.receipt_line.receipt.receipt_type unless @receipt_types.include?(container_content.receipt_line.receipt.receipt_type) 
      end
    end
    children.each do |child_container|
      @receipt_types << child_container.receipt_types
    end
    @receipt_types.flatten!
    @receipt_types.uniq!
    @receipt_types
  end
 
  def product_categories
    @product_categories = []
    self.container_contents.each do |container_content|
      @product_categories << container_content.product.product_category unless @product_categories.include?(container_content.product.product_category) || container_content.product.product_category.nil? 
    end
    children.each do |child_container|
      @product_categories << child_container.product_categories
    end
    @product_categories.flatten!
    @product_categories.uniq!
    @product_categories
  end
 
  def product_subcategories
    @product_subcategories = []
    self.container_contents.each do |container_content|
      @product_subcategories << container_content.product.product_category unless @product_subcategories.include?(container_content.product.product_category) || container_content.product.product_category.nil? 
    end
    children.each do |child_container|
      @product_subcategories << child_containe.product_subcategories
    end
    @product_subcategories.flatten!
    @product_subcategories.uniq!
    @product_subcategories
  end


  def storage_attributes
    @storage_attributes = {}
    receipt_types.count ==1 ? @storage_attributes["receipt_type_id"] = @receipt_types.first.id : nil
    product_categories.count == 1 ? @storage_attributes["product_category_id"] = @product_categories.first.id : nil
    product_subcategories.count == 1 ? @storage_attributes["product_subcategory_id"] = @product_subcategories.first.id : nil 
    uom ? @storage_attributes["uom_id"] = @uom.id : nil
    supplier ? @storage_attributes["supplier_id"] = supplier.id : nil
    @storage_attributes  
  end

  def content_quantity(criteria = {})
  	@content_quantity = 0
  	self.container_contents.each do |container_content|
  	  @content_quantity += container_content.quantity if container_content.attributes_match?(criteria)
  	end
  	@content_quantity
  end
  
  
  def total_quantity(criteria = {})
    @total_quantity = content_quantity(criteria)	
    children.each do |container|
    	@total_quantity += container.total_quantity(criteria)
    end
    @total_quantity
  end
  
  def receipts
    @receipts = []
    self.container_contents.each do |container_content| 
      unless container_content.receipt_line.nil?
        @receipts << container_content.receipt_line.receipt unless @receipts.include?(container_content.receipt_line.receipt)
      end
    end
    children.each {|child_container| @receipts << child_container.receipts}
    @receipts.flatten!
    @receipts.uniq!
    @receipts
  end
  
  def supplier
    @supplier = nil
    @supplier = receipts.first.supplier if receipts.count == 1
    @supplier
  end


  def uom
    @uom = nil
    if single_product?
      product_packages = products.first.product_packages
      index = 0
      while @uom.nil? and index <= product_packages.count
        @uom = product_packages[index].uom if total_quantity >= product_packages[index].quantity
	      index += 1
      end
    end
    @uom
  end 
  
  	 
  def total_volume
    @total_volume = direct_volume
    children.each do |child_container|
      @total_volume += child_container.total_volume
    end
    @total_volume    	    
  end  

  
  def total_weight
    @total_weight = direct_weight
    children.each do |child_container|
      @total_weight += child_container.total_weight
    end    
    @total_weight
  end
  
  def self.create_from_receipt_lines(lp, container_location)
    @receipt_lines = ReceiptLine.where(:lp => lp).all
    container = nil
    unless @receipt_lines.empty?
      container = Container.new(:lp => lp, :container_location => container_location)
      container.save!
      @receipt_lines.each do |receipt_line|
        container_content = ContainerContent.new(:container_id => container.id, :product_id => receipt_line.product_id,:lot_id => receipt_line.lot_id,:product_status_id =>receipt_line.product_status_id, :quantity =>receipt_line.quantity, :receipt_line_id => receipt_line.id)
        container_content.save
      end
    end
    container
  end
  
  
  def orders
    @orders = []
    @orders << self.direct_orders
    children.each do |container|
      @orders = container.orders
    end
    @orders.flatten!
    @orders.unique!
    @orders
  end
  
  def valid_for_storage?
    self.orders.empty?
  end


  protected
    
    def direct_orders
      @direct_orders = []
      self.container_contents.each do |container_content|
        @direct_orders << container_content.order_line.order
      end
      @direct_orders   
    end
    
    def direct_weight
      @direct_weight = 0
      self.container_contents.each do |container_content|
        @direct_weight += container_content.uom_quantity*container_content.product_package.weight
      end
      @direct_weight
    end
    
    def direct_volume
      @direct_volume = 0
      self.container_contents.each do |container_content|
        @direct_volume += container_content.uom_quantity*container_content.product_package.volume
      end
      @direct_volume
    end
    

end
