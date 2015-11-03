class Article
@@table_name='Articles' #table name
@@table_projection= "Title" #all fields

def self.byId(id)
 puts "Table Name is "+@@table_name
 puts "Projection to return is "+@@table_projection
  return {:table_name => @@table_name, :key => {:ArticleId => id},  :projection_expression => @@table_projection}
end


def initialize(hash)
    hash.each do |k,v|
      self.instance_variable_set("@#{k}", v)
      self.class.send(:define_method, k, proc{self.instance_variable_get("@#{k}")})
      self.class.send(:define_method, "#{k}=", proc{|v| self.instance_variable_set("@#{k}", v)})
    end
  end
end
