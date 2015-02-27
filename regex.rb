ENV['SSL_CERT_FILE'] = File.expand_path('C:/Projects/Secutey/cacert.pem', __FILE__)

def readFile
	require 'open-uri'

	regex_list = [
		/<script(.*)http:(.*)\.js/,
		/<img (.*)http:(.*)/,
		/<link href(.*)http:(.*)\.css/
	]
	
	# Input URL
	puts("URL eingeben (Beispiel: https://www.example.de):\n")
	url = gets
	url = url.chomp
	
	check_result = true	

	# open URL and get source code
	# check if website opens resources with http://
	open(url) do |source|
		source.each_line.with_index do |line, index| 
			regex_list.each do |regex|
				result = line.match regex
				unless result.nil?
					check_result = false
					puts index + 1
					puts result
				end
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
end	

puts readFile