{-# LANGUAGE OverloadedStrings #-}

import Network.HTTP.Types
import Web.Scotty

main = scotty 8000 $ do
  get "/" $ do
    text "This was a GET request!" -- send 'text/plain' response
  delete "/" $ do
    html "This was a DELETE request!" -- send 'text/html' response
  post "/" $ do
    text "This was a POST request!"
  put "/" $ do
    text "This was a PUT request!"
