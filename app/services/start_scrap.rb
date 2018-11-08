require 'nokogiri'
require 'open-uri'

class StartScrap
  attr_reader :cryptos

  def initialize
    @base_url = "https://coinmarketcap.com"
    @index_url = "https://coinmarketcap.com/all/views/all"
    @cryptos = {} # Hash sous la forme {"bitcoin" => { infos } }
    get_all_the_urls_of_cryptos
  end

  def perform
    get_all_the_urls_of_cryptos
  end

  def get_crypto_values(crypto)
    p "crypto : #{crypto}"
    page = Nokogiri::HTML(open(crypto[:url]))
    @cryptos[crypto[:name]][:value] = page.xpath("//*[@id='quote_price']/span[1]").text
    p "text : #{@cryptos[crypto[:name]]} "
  end

  def get_all_the_urls_of_cryptos
    page = Nokogiri::HTML(open(@base_url))
    page.xpath("//a[@class = 'link-secondary']/@href").each do |xp|
      name = xp.text.split('/')[-1]
      url = @base_url + xp.text
      @cryptos[name] = {name: name, url: url}
    end
  end
end
