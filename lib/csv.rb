require 'csv'
FILEPATH = "/Users/dougberks/code/dmbf29/fullstack-challenges/01-Ruby/06-Parsing/Reboot-01-Christmas-list/lib/gifts.csv"

def save_csv(gift_list)
  CSV.open(FILEPATH, 'wb') do |csv|
    # We had headers to the CSV
    csv << ['name', 'bought']
    # TODO: store each gift
    gift_list.each do |name, bought|
      csv << [name, bought]
    end
  end
end


def load_csv
  gift_list = {}
  CSV.foreach(FILEPATH, headers: :first_row, header_converters: :symbol) do |row|
    # TODO: build new gift from information stored in each row
    name = row[:name]
    bought = row[:bought] == 'true' # this turns a string 'true' to boolean true
    gift_list[name] = bought
  end
  gift_list
end
