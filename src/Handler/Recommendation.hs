{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Recommendation where

import Import

getRecommendation1R :: RecommendationId -> Handler Value
getRecommendation1R recommendationId = do
    recommendation <- runDB $ get404 recommendationId

    return $ object ["recommendation" .= (Entity recommendationId recommendation)]

postRecommendation2R :: Handler Value
postRecommendation2R = do
    addHeader "Access-Control-Allow-Origin" "*"
    addHeader "Access-Control-Allow-Methods" "*"
    recommendation <- requireCheckJsonBody :: Handler Recommendation
    recommendationId <- runDB $ insert recommendation

    sendStatusJSON ok200 (object ["recommendationId" .= recommendationId])

getRecommendationsR :: Handler Value
getRecommendationsR = do
    recommendations <- runDB $ selectList [] [Desc RecommendationId]
    sendStatusJSON ok200 (object ["recommendations" .= recommendations])
