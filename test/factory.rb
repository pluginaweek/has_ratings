module Factory
  # Build actions for the model
  def self.build(model, &block)
    name = model.to_s.underscore
    
    define_method("#{name}_attributes", block)
    define_method("valid_#{name}_attributes") {|*args| valid_attributes_for(model, *args)}
    define_method("new_#{name}")              {|*args| new_record(model, *args)}
    define_method("create_#{name}")           {|*args| create_record(model, *args)}
  end
  
  # Get valid attributes for the model
  def valid_attributes_for(model, attributes = {})
    name = model.to_s.underscore
    send("#{name}_attributes", attributes)
    attributes.stringify_keys!
    attributes
  end
  
  # Build an unsaved record
  def new_record(model, *args)
    attributes = valid_attributes_for(model, *args)
    record = model.new(attributes)
    attributes.each {|attr, value| record.send("#{attr}=", value) if model.accessible_attributes && !model.accessible_attributes.include?(attr) || model.protected_attributes && model.protected_attributes.include?(attr)}
    record
  end
  
  # Build and save/reload a record
  def create_record(model, *args)
    record = new_record(model, *args)
    record.save!
    record.reload
    record
  end
  
  build Rating do |attributes|
    attributes[:ratable] = create_video unless attributes.include?(:ratable)
    attributes[:rater] = create_user unless attributes.include?(:rater)
    attributes[:value] = create_rating_value unless attributes.include?(:value)
  end
  
  build RatingValue do |attributes|
    attributes.reverse_merge!(
      :name => 'awesome',
      :value => 10
    )
  end
  
  build User do |attributes|
    attributes.reverse_merge!(
      :login => 'admin'
    )
  end
  
  build Video do |attributes|
    attributes.reverse_merge!(
      :name => 'Rick Roll'
    )
  end
end
