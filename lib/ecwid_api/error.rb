module EcwidApi
  class Error < StandardError; end;

  class ResponseError < Error
    def initialize(response)
      super get_response_info(response)
    end

    def get_response_info(response)
      url = response.env.url
      url.query = url.query.to_s.sub(/token=[^&]*/, 'token=**SECRET**')
      message = "url: #{url}, response (#{response.status})\n#{response.body}"
      if response.respond_to?(:reason_phrase)
        message = "#{response.reason_phrase} #{message}"
      end

      message
    end
  end
  class UpdateError < ResponseError; end;

end
