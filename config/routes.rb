# frozen_string_literal: true

Rails.application.routes.draw do
  resources :invoices
  resources :customers
  resources :reports do
    get :pay, on: :collection
    get :reset, on: :collection
  end

  root 'customers#index'
end
