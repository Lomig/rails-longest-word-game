# frozen_string_literal: true

Rails.application.routes.draw do
  root "games#index"
  get "/new", to: "games#new"
  post "/score", to: "games#score"
  get "/score", to: "games#index"
end
