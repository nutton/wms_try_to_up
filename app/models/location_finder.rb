require 'singleton'
class LocationFinder
  include Singleton

  attr_accessor :container

  def locate(*args)
    exclude_location = args[:exclude]
    
  end

  def get_matching_storage_strategy
    
  end

  def evaluate_locations(storage_zone, *args)
    exclude_location 
  end

  def get_next_container
    @location_finder_queue = LocationFinderQueue.new
    self.container = @location_finder_queue.get_next_container
  end

end
