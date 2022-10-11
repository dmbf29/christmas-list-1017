require_relative 'scraper'
require_relative 'csv'

def display_list(list) # give a hash as a parameter
  list.each_with_index do |(gift, bought), index|
    x_mark = bought ? 'X' : ' '
    puts "#{index + 1} - [#{x_mark}] #{gift}"
  end
end

puts '-----------------------------------'
puts "🎄 Welcome to the Christmas List 🎄"
puts '-----------------------------------'
action = nil
# 'gift' => bought
gift_list = load_csv
until action == 'quit'
  puts 'Which action [list|add|mark|idea|delete|quit]?'
  action = gets.chomp

  case action
  when 'list'
    display_list(gift_list)
  when 'add'
    puts "What gift do you want to add?"
    gift = gets.chomp
    gift_list[gift] = false
    puts "#{gift.capitalize} was added to the list."
    save_csv(gift_list)
  when 'mark'
    display_list(gift_list)
    puts 'Which number?'
    index = gets.chomp.to_i - 1
    gifts = gift_list.keys
    gift = gifts[index]
    # update the gift from the list -> hash[key] = new_value
    # gift_list[gift] = true
    gift_list[gift] = !gift_list[gift]
    puts "#{gift.capitalize} was updated."
    save_csv(gift_list)
  when 'delete'
    display_list(gift_list)
    puts 'Which number?'
    index = gets.chomp.to_i - 1
    gifts = gift_list.keys
    gift = gifts[index]
    gift_list.delete(gift)
    puts "#{gift.capitalize} was removed from the list."
    save_csv(gift_list)
  when 'idea'
    puts 'What are you looking for on Etsy?'
    article = gets.chomp
    # etsy_list (hash) = call the scraper method -> to basically do all the scraping part
    etsy_list = scraper(article)
    # display the results of the scraper -> give the etsy_list to the display method
    display_list(etsy_list)
    # ask user to choose a number
    # index = get the index from the user -> convert to integer and subtract 1
    puts 'Which number?'
    index = gets.chomp.to_i - 1
    # etsy_gifts = get the keys from the etsy_list
    etsy_gifts = etsy_list.keys
    # etsy_gift = use the etsy_gifts keys with the index to get the key
    etsy_gift = etsy_gifts[index]
    # add the etsy_gift into the gift_list -> hash[key] = false
    gift_list[etsy_gift] = false
    # tell user etsy_gift was added
    puts "#{etsy_gift.capitalize} was added to your list."
    save_csv(gift_list)
  when 'quit'
    save_csv(gift_list)
    puts 'Goodbye'
  else
    puts 'Wrong action.'
  end
end
