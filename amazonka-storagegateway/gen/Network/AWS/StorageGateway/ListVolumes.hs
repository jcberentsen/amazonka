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

-- Module      : Network.AWS.StorageGateway.ListVolumes
-- Copyright   : (c) 2013-2014 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

-- | This operation lists the iSCSI stored volumes of a gateway. Results are
-- sorted by volume ARN. The response includes only the volume ARNs. If you
-- want additional volume information, use the DescribeStorediSCSIVolumes API.
-- The operation supports pagination. By default, the operation returns a
-- maximum of up to 100 volumes. You can optionally specify the Limit field in
-- the body to limit the number of volumes in the response. If the number of
-- volumes returned in the response is truncated, the response includes a
-- Marker field. You can use this Marker value in your subsequent request to
-- retrieve the next set of volumes.
module Network.AWS.StorageGateway.ListVolumes
    (
    -- * Request
      ListVolumes
    -- ** Request constructor
    , listVolumes
    -- ** Request lenses
    , lvGatewayARN
    , lvLimit
    , lvMarker

    -- * Response
    , ListVolumesResponse
    -- ** Response constructor
    , listVolumesResponse
    -- ** Response lenses
    , lvrGatewayARN
    , lvrMarker
    , lvrVolumeInfos
    ) where

import Network.AWS.Prelude
import Network.AWS.Request
import Network.AWS.StorageGateway.Types

data ListVolumes = ListVolumes
    { _lvGatewayARN :: Text
    , _lvLimit      :: Maybe Natural
    , _lvMarker     :: Maybe Text
    } deriving (Eq, Ord, Show, Generic)

-- | 'ListVolumes' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'lvGatewayARN' @::@ 'Text'
--
-- * 'lvLimit' @::@ 'Maybe' 'Natural'
--
-- * 'lvMarker' @::@ 'Maybe' 'Text'
--
listVolumes :: Text -- ^ 'lvGatewayARN'
            -> ListVolumes
listVolumes p1 = ListVolumes
    { _lvGatewayARN = p1
    , _lvMarker     = Nothing
    , _lvLimit      = Nothing
    }

lvGatewayARN :: Lens' ListVolumes Text
lvGatewayARN = lens _lvGatewayARN (\s a -> s { _lvGatewayARN = a })

-- | Specifies that the list of volumes returned be limited to the specified
-- number of items.
lvLimit :: Lens' ListVolumes (Maybe Natural)
lvLimit = lens _lvLimit (\s a -> s { _lvLimit = a })

-- | A string that indicates the position at which to begin the returned list
-- of volumes. Obtain the marker from the response of a previous List iSCSI
-- Volumes request.
lvMarker :: Lens' ListVolumes (Maybe Text)
lvMarker = lens _lvMarker (\s a -> s { _lvMarker = a })

instance ToPath ListVolumes where
    toPath = const "/"

instance ToQuery ListVolumes where
    toQuery = const mempty

instance ToHeaders ListVolumes

instance ToBody ListVolumes where
    toBody = toBody . encode . _lvGatewayARN

data ListVolumesResponse = ListVolumesResponse
    { _lvrGatewayARN  :: Maybe Text
    , _lvrMarker      :: Maybe Text
    , _lvrVolumeInfos :: [VolumeInfo]
    } deriving (Eq, Show, Generic)

-- | 'ListVolumesResponse' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'lvrGatewayARN' @::@ 'Maybe' 'Text'
--
-- * 'lvrMarker' @::@ 'Maybe' 'Text'
--
-- * 'lvrVolumeInfos' @::@ ['VolumeInfo']
--
listVolumesResponse :: ListVolumesResponse
listVolumesResponse = ListVolumesResponse
    { _lvrGatewayARN  = Nothing
    , _lvrMarker      = Nothing
    , _lvrVolumeInfos = mempty
    }

lvrGatewayARN :: Lens' ListVolumesResponse (Maybe Text)
lvrGatewayARN = lens _lvrGatewayARN (\s a -> s { _lvrGatewayARN = a })

lvrMarker :: Lens' ListVolumesResponse (Maybe Text)
lvrMarker = lens _lvrMarker (\s a -> s { _lvrMarker = a })

lvrVolumeInfos :: Lens' ListVolumesResponse [VolumeInfo]
lvrVolumeInfos = lens _lvrVolumeInfos (\s a -> s { _lvrVolumeInfos = a })

-- FromJSON

instance AWSRequest ListVolumes where
    type Sv ListVolumes = StorageGateway
    type Rs ListVolumes = ListVolumesResponse

    request  = post'
    response = jsonResponse $ \h o -> ListVolumesResponse
        <$> o .: "GatewayARN"
        <*> o .: "Marker"
        <*> o .: "VolumeInfos"
