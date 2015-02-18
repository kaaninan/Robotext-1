class Product

  @@total_product = 0

  attr_accessor :name, :price

  def initialize(name, price)
    @@total_product += 1
    @name = name
    @price = price
  end

  def to_s
    "Name: #{@name}, Price in cent: #{@price}"
  end

  def price_in_tl
    Float(@price)/100
  end

  def self.total_product
    @@total_product
  end

end

pencil = Product.new('Lead Pencil', 10)
puts pencil
puts Product.total_product

book = Product.new("Kitap", 20)
puts book
puts Product.total_product