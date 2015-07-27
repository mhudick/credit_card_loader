require 'luhn-ruby'
require 'csv'
class Uploader

  def initialize
    @customers = Hash.new
  end

  def importer
   filename = ARGV.first
   text = open(filename).read
    if text.present?
      p "file opened and read successfully"
    else
      p "file failed to open or read"
    end
    CSV.foreach(text, {headers: false, col_sep: "\t"}) do |r|
       string = r
       array = string.split
       customer = @customers
       customer."#{array[0]}"(array[1],array[2],array[3])
    end
  end

  def self.add(name, number, value)
    customer = @customers
    if customer.has_key?(name) && customer.luhn_check(number)
      customer[name] = 0
    else
      customer[name] = "error"
    end
  end

  def self.charge(name, number, value)
    customer = @customers
    if customer.has_key?(name) && customer.luhn_check(number)
      customer[name] += value.slice "$"
    else
      customer[name] = "error"
    end
  end

  def self.credit(name, number, value)
    customer = @customers
    if customer.has_key?(name) && customer.luhn_check(number)
      customer[name] -= value.slice "$"
    else
      customer[name] = "error"
    end
  end

  def self.luhn_check(number)
    Luhn.valid? number.to_i
  end
end
