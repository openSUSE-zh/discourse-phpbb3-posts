require 'mysql2'
require 'bb2md'

module PHPBB3_BB2MD
  # extract posts from database
  class Parser
    def initialize(conf)
      # {'source'=>ostruct, 'dest'=>ostruct}
      @conf = PHPBB3_BB2MD::Config.new(conf).hash
      @source_ostruct = @conf['source']
      @mysql = Mysql2::Client.new(:host => @source_ostruct.host,
				   :port => @source_ostruct.port,
				   :database => @source_ostruct.schema,
				   :username => @source_ostruct.username,
				   :password => @source_ostruct.password)
    end

    def parse
      data = get_data_from_posts_table
      data.each do |row|
        unless row[2] == row[4]
          @mysql.query("UPDATE #{@source_ostruct.table_prefix}posts SET post_text=\"#{@mysql.escape(row[2])}\" WHERE bbcode_uid=\"#{row[0]}\"")
        end

        unless row[1] == row[3]
          @mysql.query("UPDATE #{@source_ostruct.table_prefix}posts SET post_subject=\"#{@mysql.escape(row[1])}\" WHERE bbcode_uid=\"#{row[0]}\"")
        end
      end
    end

    private

    def get_data_from_posts_table
      posts_data = @mysql.query("SELECT bbcode_uid,post_text,post_subject FROM #{@source_ostruct.table_prefix}posts")
      data = []
      posts_data.each do |row|
	post_text = BB2MD::Parser.new(row['post_text'], row['bbcode_uid']).parse
        data << [row['bbcode_uid'], LatinCJK::Parser.new(row['post_subject']).text,
                 post_text, row['post_subject'], row['post_text']]
      end
      data
    end
  end
end
