## Simple Wordpress Export Tool
## Frank Caron, 2015

## A simple utility which converts Wordpress blog entries in a MySQL DB to static HTML pages 
## on your local machine.

## =============
## Reqs
## =============

require 'rubygems'
require 'mysql2'

## =============
## Script Config
## =============

## Database
host = 'localhost'
database = 'your_db_name'
db_user = 'your_db_username'
db_password = 'your_db_password'
port = 3306

## Files
file_location = "posts/"
file_type = "html"
style_css = "style/style.css"

## ==============
## Script
## ==============

## Connect

puts "LOG | Initializing..."

begin  
    client = Mysql2::Client.new(:host => host, 
                                :username => db_user, 
                                :password => db_password,
                                :database => database,
                                :port => port)  
rescue Exception => e  
    puts "ERROR | Couldn't initialize a connection. Exception: " + e.message  
end

## Pull Posts

puts "LOG | Successfully connected to your database."
puts "LOG | Pulling up all your posts..."

begin  
    results = client.query("SELECT * FROM wp_posts where post_status = 'publish' OR post_status = 'private'")
rescue Exception => e  
    puts "ERROR | Couldn't select your posts. Exception: " + e.message  
end

## Write files

puts "LOG | Writing your post content to files."

## Iterate through rows

results.each do |row|

    # Unless the row doesn't exist
    unless row["dne"]
        # Grab attributes
        post_date = row["post_date"].to_s.split(' ',2)[0]
        post_title = row["post_title"]
        post_body = row["post_content"]

        # Replace double spaces with breaks
        post_body.encode(post_body.encoding, :universal_newline => true)
        post_body.gsub! "\r\n", "<br />\n"

        puts "LOG | Writing: " + post_body

        # Create file
        begin
            # Open output stream
            file = File.open(file_location + post_date + "." + file_type, "w:UTF-16")

            # Write HTML base
            file.write("<html>\n")
            file.write("<head>\n")
            file.write("    <title>" + post_title + "</title>\n")
            file.write("  <link rel=\"stylesheet\" href=\"" + style_css + "\">\n")
            file.write("</head>\n")
            file.write("<body>\n")
            file.write("<div class=\"content\">\n")
            file.write(post_body)
            file.write("\n</div>\n</body>\n</html>")
        rescue IOError => e
            # Catch error
            puts "ERROR | Couldn't write the post" + post_date + ". Exception: " + e.message  
        ensure
            # Close file
            file.close unless file == nil
        end
    end

end

## Wrap
puts "LOG | All done."



