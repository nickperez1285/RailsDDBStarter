class Article
@@table_name='Articles' #table name
@@table_projection= "Title" #all fields

#ORM-ish functions
  def self.getSingleItem(id)
    return self.new(Aws::DynamoDB::Client.new.get_item(
        {:table_name => @@table_name, :key => {:ArticleId => id},  :projection_expression => @@table_projection}
    ).item)
  end

  def self.SaveItem(id)
    Aws::DynamoDB::Client.new.put_item({ table_name: @@table_name, item: self.attributes });
  end

#provides coverage for projection values without specific instnace accessor
def initialize(hash)
    hash.each do |k,v|
      self.instance_variable_set("@#{k}", v)
      self.class.send(:define_method, k, proc{self.instance_variable_get("@#{k}")})
      self.class.send(:define_method, "#{k}=", proc{|v| self.instance_variable_set("@#{k}", v)})
    end
  end
#maps current instance variables to a hash for projection
def attributes
    instance_variables.map do |var|
      [var[1..-1].to_sym, instance_variable_get(var)]
    end.to_h
  end
end
