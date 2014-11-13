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

-- Module      : Network.AWS.EMR.RemoveTags
-- Copyright   : (c) 2013-2014 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

-- | Removes tags from an Amazon EMR resource. Tags make it easier to associate
-- clusters in various ways, such as grouping clusters to track your Amazon
-- EMR resource allocation costs. For more information, see Tagging Amazon EMR
-- Resources. The following example removes the stack tag with value Prod from
-- a cluster:.
module Network.AWS.EMR.RemoveTags
    (
    -- * Request
      RemoveTags
    -- ** Request constructor
    , removeTags
    -- ** Request lenses
    , rtResourceId
    , rtTagKeys

    -- * Response
    , RemoveTagsResponse
    -- ** Response constructor
    , removeTagsResponse
    ) where

import Network.AWS.Prelude
import Network.AWS.Request
import Network.AWS.EMR.Types

data RemoveTags = RemoveTags
    { _rtResourceId :: Text
    , _rtTagKeys    :: [Text]
    } deriving (Eq, Ord, Show, Generic)

-- | 'RemoveTags' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'rtResourceId' @::@ 'Text'
--
-- * 'rtTagKeys' @::@ ['Text']
--
removeTags :: Text -- ^ 'rtResourceId'
           -> RemoveTags
removeTags p1 = RemoveTags
    { _rtResourceId = p1
    , _rtTagKeys    = mempty
    }

-- | The Amazon EMR resource identifier from which tags will be removed. This
-- value must be a cluster identifier.
rtResourceId :: Lens' RemoveTags Text
rtResourceId = lens _rtResourceId (\s a -> s { _rtResourceId = a })

-- | A list of tag keys to remove from a resource.
rtTagKeys :: Lens' RemoveTags [Text]
rtTagKeys = lens _rtTagKeys (\s a -> s { _rtTagKeys = a })

instance ToPath RemoveTags where
    toPath = const "/"

instance ToQuery RemoveTags where
    toQuery = const mempty

instance ToHeaders RemoveTags

instance ToBody RemoveTags where
    toBody = toBody . encode . _rtResourceId

data RemoveTagsResponse = RemoveTagsResponse
    deriving (Eq, Ord, Show, Generic)

-- | 'RemoveTagsResponse' constructor.
removeTagsResponse :: RemoveTagsResponse
removeTagsResponse = RemoveTagsResponse

-- FromJSON

instance AWSRequest RemoveTags where
    type Sv RemoveTags = EMR
    type Rs RemoveTags = RemoveTagsResponse

    request  = post'
    response = nullaryResponse RemoveTagsResponse
