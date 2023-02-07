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
        return all_gossips[nb]
    end

    def self.edit(author, content, id)
        nb = id.to_i
        nb -= 1
        all_gossips = self.all
        all_gossips[nb].author = author
        all_gossips[nb].content = content
        CSV.open('db/gossip.csv', 'w') { |csv| all_gossips.each{|row| csv << [row.author,row.content]}}

    end
end

