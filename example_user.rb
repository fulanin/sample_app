class User

  #variaveis momentaneos
  #não ficam armazenadas no bd
  attr_accessor :firstname, :lastname, :email

  def initialize (attributes = {})
    @firstname = attributes[:firstname]
    @lastname = attributes[:lastname]
    @email = attributes[:email]
  end

  def full_name
    "#{@firstname} #{@lastname}"
  end

  def alphabetical_name
    "#{@lastname}, #{@firstname}"
  end

  def formatted_email
    "#{self.full_name} <#{@email}>"
  end
end