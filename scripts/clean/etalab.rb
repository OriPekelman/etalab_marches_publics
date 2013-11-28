require "simple-spreadsheet"
require "json"
require 'elasticsearch'
require "pry"

class Etalab
end

class Etalab::Importer

  def initialize(file_name, mapping, index_name)
    @mapping = mapping
    @index_name = "etalab_#{index_name}"
    @h = {}

    # Connect to localhost:9200 by default:
    @es = Elasticsearch::Client.new log: false
  end
  
  def index!(doc,id)
    # Index a document:
    @es.index index: @index_name,
             type:  @index_name,
             id: id,
             body: doc
  end
  
  
  def import!

    @first_row.upto(@last_row) do |line|

      @mapping.each_with_index do |field, column|
        key = field.keys[0]
        val =  self.public_send(key, @s.cell(line, column +1))  
        puts "." if (column % 10)==0
        @h[key] = val
      end
      self.index!(@h, line)
    end
    @last_row
  end
end
