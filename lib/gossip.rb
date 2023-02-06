require 'pry'
require 'csv'

class Gossip
    attr_accessor :author, :content

    def initialize(author, content)
        @author = author
        @content = content

    end

    def save
        CSV.open("./db/gossip.csv", "ab") do |csv|
            csv << [@author, @content]
        end
    end

    def self.all
        all_gossips = []
        CSV.read("db/gossip.csv").each do |row|
            all_gossips << Gossip.new(row[0], row[1])
        end
        
        return all_gossips
    end

    def self.find(id)
        all_gossips = Gossip.all
        nb = id.to_i
        nb -= 1
        puts all_gossips[nb].author
        puts all_gossips[nb].content
        return all_gossips[nb]
    end
end

#binding.pry