require 'securerandom'

if development?
  require 'sinatra/reloader'
end


def campaign_codes
  result = []
  if @numbers > 0
    @numbers.times {
      result << random_characters
    }
  end
  result << ''
end

def random_characters
  SecureRandom.hex(@length.quo(2).ceil).ljust(@length)
end


@title = 'Create Campaign Codes'

get '/' do
  haml :index
end

post '/create' do
  @length = params['length'].to_i
  @numbers = params['num'].to_i

  content_type "text/plain"
  attachment "campaign_codes.txt"
  campaign_codes.join("\n")
end
