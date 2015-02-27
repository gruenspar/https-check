ENV['SSL_CERT_FILE'] = File.expand_path('C:/Projects/Secutey/cacert.pem', __FILE__)

require 'open-uri'

# Input URL
puts("URL eingeben (Beispiel: https://www.example.de):\n")
url = gets
url = url.chomp

check_result = true	
counter = 0

# url = File.new("Quelltext.html", "r")

# open URL and get source code
# check if website opens resources with http://
open(url) do |source|
	source.each_line do |line| 
		counter = counter + 1
		result = line.match(/<img (.*)http:(.*)/)
		unless result.nil?
			check_result = false
			puts counter
			puts result
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

# line.match(/<img (.*)http:(.*)/) or line.match(/<script(.*)http\:(.*)/) or line.match(/<link href(.*)http:(.*).css(.*)/)