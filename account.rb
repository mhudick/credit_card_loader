require 'rubygems'
require 'luhn'
require 'csv'

  account = Hash.new

  def importer(account)
    array = []
   filename = ARGV.first
   text = open(filename)
    CSV.foreach(text, {headers: false, col_sep: "\t"}) do |r|
     string = r[0]
     str_array = string.split(" ").map(&:to_s)
     if str_array[0] == "Add"
       add(account, str_array[1], str_array[2].to_i, str_array[3].delete("$").to_i)
     elsif str_array[0] == "Charge"
       charge(account, str_array[1], str_array[2].delete("$").to_i)
     elsif str_array[0] == "Credit"
       credit(account, str_array[1], str_array[2].delete("$").to_i)
     else
       "there was an error in submission"
     end
   end
    print(account)
  end

  def add(account, name, number, value)
    if luhn_check(number)
      account[name] = 0
    else
      account[name] = "error"
    end
  end

  def charge(account,name, value)
    unless account[name] == "error"
      if account.has_key?(name)
        account[name] += value
      end
    end
  end

  def credit(account,name, value)
    unless account[name] == "error"
      if account.has_key?(name)
        account[name] -= value
      end
    end
  end

  def luhn_check(number)
    Luhn.valid? number
  end

  def print(account)
    account.each do |k , v|
      puts k.to_s + ':' + v.to_s
    end
  end

  importer(account)
