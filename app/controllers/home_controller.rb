class HomeController < ApplicationController

  def index
    # Initialisation du service
    coin_market_scrapper = StartScrap.new
    @cryptos = coin_market_scrapper.cryptos
  end

  def show
    coin_market_scrapper = StartScrap.new
    @cryptos = coin_market_scrapper.cryptos

    coin_market_scrapper.get_crypto_values(@cryptos[params[:Crypto]]) # Met à jour la valeur de la crypto
    @name = @cryptos[params[:Crypto]][:name]
    @value = coin_market_scrapper.cryptos[params[:Crypto]][:value] # Récupère la value pour l'afficher dans la view
  end

end
