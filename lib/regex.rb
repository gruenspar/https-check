require 'open-uri'

ENV['SSL_CERT_FILE'] = File.expand_path('../cert/cacert.pem', File.dirname(__FILE__))

class HttpsCheck

    def self.regex_list
        [
            /<script(.*)http:(.*)\.js/,
            /<img (.*)http:(.*)/,
            /<link href(.*)http:(.*)\.css/
        ]
    end

    def self.print_result result
        if result == false
            # insecure
            puts "\nWARNING: HTML contains insecure asset references."
        else
            # secure
            puts "\nOK"
        end
    end

    def self.check url
        url = url.chomp

        check_result = true

        # open URL and get source code
        # check if website opens resources with http://
        open(url) do |source|
            check_result = check_html(source)
        end

        print_result check_result
    end

    def self.check_file(file_path)
        check_result = true

        File.open(file_path) do |source|
            check_result = check_html(source)
        end

        print_result check_result
    end

    def self.check_html(html)
        check_result = true

        html.each_line.with_index do |line, index|
            line_number = index + 1

            regex_list.each do |regex|
                result = line.match regex
                unless result.nil?
                    check_result = false
                    puts "L#{line_number}:  #{result}"
                end
            end
        end

        check_result
    end

end

