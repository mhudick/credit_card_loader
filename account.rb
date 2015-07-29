require 'rubygems'
require 'luhn'
require 'csv'

  account = Hash.new{|h,k| h[k] = []}

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
   write_to_file(account)
    print(account)
  end

  def add(account, name, number, limit)
    if luhn_check(number)
      account[name] << 0
      account[name] << limit
    else
      account[name] = "error"
    end
  end

  def charge(account,name, value)
    unless account[name] == "error"
      if account.has_key?(name) && account[name][0] + value <= account[name][1]
        account[name][0] += value
      end
    end
  end

  def credit(account,name, value)
    unless account[name] == "error"
      if account.has_key?(name)
        account[name][0] -= value
      end
    end
  end

  def luhn_check(number)
    Luhn.valid? number
  end

  def sorter(account)
    account.sort
  end

  def print(account)
    sorter(account)
    account.each do |k , v|
      unless v == "error"
        puts k.to_s + ':' + v[0].to_s
      else
        puts k.to_s + ':' + v.to_s
      end
    end
  end

  def write_to_file(account)
    
  end

  importer(account)
