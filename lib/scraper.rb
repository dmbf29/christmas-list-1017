require 'open-uri'
require 'nokogiri'

def scraper(article)
  # filepath = "/Users/dougberks/code/dmbf29/fullstack-challenges/01-Ruby/06-Parsing/Reboot-01-Christmas-list/lib/results.html"
  # html_content = File.open(filepath)
  html_content = URI.open("https://www.etsy.com/search?q=#{article}", "User-Agent" => "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:89.0) Gecko/20100101 Firefox/89.0").read
  doc = Nokogiri::HTML(html_content)

  # DONT PUTS IN HERE
  # create an empty hash
  etsy_list = {}
  doc.search('.v2-listing-card__info .v2-listing-card__title').first(5).each do |element|
    # add each scraped item into the hash -> hash[key] = false
    gift = element.text.strip.split.first(5).join(' ')
    # add the gift into the hash
    etsy_list[gift] = false
  end
  return etsy_list
end

# eventuall, use this method in the interface
# if you want to test your scraper, uncomment this line
# scraper('pillow')
# => THIS METHOD SHOULD RETURN A... HASH
