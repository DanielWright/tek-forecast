Rails.application.routes.draw do
  get "/forecast", to: "forecast#fetch"
end
