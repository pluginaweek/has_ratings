module Factory
  # Build actions for the class
  def self.build(klass, &block)
    name = klass.to_s.underscore
    define_method("#{name}_attributes", block)
    
    module_eval <<-end_eval
      def valid_#{name}_attributes(attributes = {})
        #{name}_attributes(attributes)
        attributes
      end
      
      def new_#{name}(attributes = {})
        #{klass}.new(valid_#{name}_attributes(attributes))
      end
      
      def create_#{name}(*args)
        record = new_#{name}(*args)
        record.save!
        record.reload
        record
      end
    end_eval
  end
  
  build Rating do |attributes|
    attributes[:ratable] = create_video unless attributes.include?(:ratable)
    attributes[:rater] = create_user unless attributes.include?(:rater)
    
    attributes.reverse_merge!(
      :value => :average
    )
  end
  
  build RatingValue do |attributes|
    attributes.reverse_merge!(
      :id => 6,
      :name => 'awesome',
      :value => 6
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
