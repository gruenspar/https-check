ENV['SSL_CERT_FILE'] = File.expand_path('../cert/cacert.pem', File.dirname(__FILE__))

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
		    line_number = index + 1

			regex_list.each do |regex|
				result = line.match regex
				unless result.nil?
					check_result = false
					puts "L#{line_number}:  #{result}"
				end
			end
		end	
	end

	if check_result == false
		# insecure
		puts "\nWARNING: #{url} contains insecure asset references."
	else
		# secure
		puts "\nOK"
	end	
end	

puts readFile
