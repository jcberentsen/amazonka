{-# LANGUAGE DeriveGeneric              #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances          #-}
{-# LANGUAGE NoImplicitPrelude          #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE RecordWildCards            #-}
{-# LANGUAGE TypeFamilies               #-}

-- {-# OPTIONS_GHC -fno-warn-unused-imports #-}
-- {-# OPTIONS_GHC -fno-warn-unused-binds  #-} doesnt work if wall is used
{-# OPTIONS_GHC -w #-}

-- Module      : Network.AWS.Route53Domains.ListOperations
-- Copyright   : (c) 2013-2014 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

-- | This operation returns the operation IDs of operations that are not yet
-- complete.
module Network.AWS.Route53Domains.ListOperations
    (
    -- * Request
      ListOperations
    -- ** Request constructor
    , listOperations
    -- ** Request lenses
    , loMarker
    , loMaxItems

    -- * Response
    , ListOperationsResponse
    -- ** Response constructor
    , listOperationsResponse
    -- ** Response lenses
    , lorNextPageMarker
    , lorOperations
    ) where

import Network.AWS.Prelude
import Network.AWS.Request
import Network.AWS.Route53Domains.Types

data ListOperations = ListOperations
    { _loMarker   :: Maybe Text
    , _loMaxItems :: Maybe Int
    } deriving (Eq, Ord, Show, Generic)

-- | 'ListOperations' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'loMarker' @::@ 'Maybe' 'Text'
--
-- * 'loMaxItems' @::@ 'Maybe' 'Int'
--
listOperations :: ListOperations
listOperations = ListOperations
    { _loMarker   = Nothing
    , _loMaxItems = Nothing
    }

-- | For an initial request for a list of operations, omit this element. If
-- the number of operations that are not yet complete is greater than the
-- value that you specified for MaxItems, you can use Marker to return
-- additional operations. Get the value of NextPageMarker from the previous
-- response, and submit another request that includes the value of
-- NextPageMarker in the Marker element. Type: String Default: None
-- Required: No.
loMarker :: Lens' ListOperations (Maybe Text)
loMarker = lens _loMarker (\s a -> s { _loMarker = a })

-- | Number of domains to be returned. Type: Integer Default: 20 Constraints:
-- A value between 1 and 100. Required: No.
loMaxItems :: Lens' ListOperations (Maybe Int)
loMaxItems = lens _loMaxItems (\s a -> s { _loMaxItems = a })

instance ToPath ListOperations where
    toPath = const "/"

instance ToQuery ListOperations where
    toQuery = const mempty

instance ToHeaders ListOperations

instance ToBody ListOperations where
    toBody = toBody . encode . _loMarker

data ListOperationsResponse = ListOperationsResponse
    { _lorNextPageMarker :: Maybe Text
    , _lorOperations     :: [OperationSummary]
    } deriving (Eq, Show, Generic)

-- | 'ListOperationsResponse' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'lorNextPageMarker' @::@ 'Maybe' 'Text'
--
-- * 'lorOperations' @::@ ['OperationSummary']
--
listOperationsResponse :: ListOperationsResponse
listOperationsResponse = ListOperationsResponse
    { _lorOperations     = mempty
    , _lorNextPageMarker = Nothing
    }

-- | If there are more operations than you specified for MaxItems in the
-- request, submit another request and include the value of NextPageMarker
-- in the value of Marker. Type: String Parent: Operations.
lorNextPageMarker :: Lens' ListOperationsResponse (Maybe Text)
lorNextPageMarker =
    lens _lorNextPageMarker (\s a -> s { _lorNextPageMarker = a })

-- | Lists summaries of the operations. Type: Complex type containing a list
-- of operation summaries Children: OperationId, Status, SubmittedDate,
-- Type.
lorOperations :: Lens' ListOperationsResponse [OperationSummary]
lorOperations = lens _lorOperations (\s a -> s { _lorOperations = a })

-- FromJSON

instance AWSRequest ListOperations where
    type Sv ListOperations = Route53Domains
    type Rs ListOperations = ListOperationsResponse

    request  = post'
    response = jsonResponse $ \h o -> ListOperationsResponse
        <$> o .: "NextPageMarker"
        <*> o .: "Operations"
