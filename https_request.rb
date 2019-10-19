require 'net/http'
require 'uri'
require 'json'

def https_request(url, body = {"text": "ERROR: NO MESSAGE."})
    uri = URI.parse(url)
    https = https_setting(uri)
    request = Net::HTTP::Post.new(uri.request_uri)
    body_json = body.to_json

    request.body = body_json
    response = https.request(request)
    return response
end

def https_setting(uri)
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl  =true
    https.verify_mode = OpenSSL::SSL::VERIFY_NONE
    return https
end
