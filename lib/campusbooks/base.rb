require 'httparty'

module CampusBooks
  class Base
    include HTTParty
    base_uri 'http://api.campusbooks.com/3/rest'
    format :xml

    protected
      def self.get_response(path, options={})
        res = self.get(path, options)
        case res['response']['status']
          when 'ok'
            return res['response']

          when 'error'
            err_count = res['response']['errors']['error'].length
            raise Error, err_count == 1 ? 'An error' : "#{err_count} errors" +
              " occured while getting path '#{path}' with options #{options.inspect}:\n  " +
              res['response']['errors']['error'].join("\n  ")
        end
      end

  end
end
