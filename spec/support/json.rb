module Helpers
  module Json
    def response_json
      JSON.parse response.body
    end
  end
end
