require 'open-uri'

# Input URL
puts("URL eingeben (Beispiel: http://example.de):\n")
url = gets
url = url.chomp

check_result = true
counter = 0

# open URL and get source code
# check if website opens resources with http://
open(url) do |source|
	source.each_line do |line| 
		counter = counter + 1
		result = line.match(/<img (.*)"http:(.*)/)
		unless result.nil?
			check_result = false
			puts counter
		end
	end		
end

if check_result == false
	# insecure
	puts "Found. Line numbers above."	
else
	# secure
	puts "Not Found"
end
