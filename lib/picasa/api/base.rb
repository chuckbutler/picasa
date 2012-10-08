module Picasa
  module API
    class Base
      attr_reader :user_id, :access_token, :authorization_header

      # @param [Hash] credentials
      # @option credentials [String] :user_id google username/email
      # @option credentials [String] :authorization_header header for authenticating requests
      def initialize(credentials = {})
        if MultiXml.parser.to_s == "MultiXml::Parsers::Ox"
          raise StandardError, "MultiXml parser is set to :ox - picasa gem will not work with it currently, use one of: :libxml, :nokogiri, :rexml"
        end
        @user_id  = credentials.fetch(:user_id)
        @authorization_header = credentials[:authorization_header]
      end

      def auth_header
        {}.tap do |header|
          unless access_token.nil?
            header["Authorization"] = authorization_header if authorization_header
          else
            header["Authorization"] = "Bearer #{@access_token}" if @access_token
          end
        end
      end
    end
  end
end
