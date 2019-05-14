# load factory_girl and shortcuts into console
def fg!
  require 'factory_girl'
  FactoryGirl.find_definitions
  include FactoryGirl::Syntax::Methods
end

class String
  def to_file(filename)
    File.open(filename, 'w') {|f| f.write(self) }
  end

  def to_pb
    system("echo '#{self}' | pbcopy")
  end
end

