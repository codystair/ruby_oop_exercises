class Person
  def name=(name)
    @first = name.split.first
    @last = name.split.last
  end

  def name
    "#{@first} #{@last}"
  end
end

person1 = Person.new
person1.name = 'John Doe'
puts person1.name
