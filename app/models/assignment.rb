class Assignment < ActiveRecord::Base

	has_many 	  :assignment_details, dependent: :destroy
	belongs_to	:warehouse
	
	validates 	:type, presence: true
	
	include AASM
  aasm :column => :state, :enum => true do 
    state          :created
    initial_state  :created
    state          :released
    state          :in_process
    state          :completed
    state          :canceled
  
  
    event :release do
      transitions :to => :released, :from => [:created]
    end
  
    event :start_processing do
      transitions :to => :in_process, :from => [:created, :released] 
    end
  
    event :cancel do
      transitions :to => :canceled, :from => [:created, :released]
    end
  
    event :complete do
      transitions :to => :completed, :from => [:created, :released, :in_process]
    end
  end
end
