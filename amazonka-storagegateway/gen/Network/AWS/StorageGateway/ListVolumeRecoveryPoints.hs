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

-- Module      : Network.AWS.StorageGateway.ListVolumeRecoveryPoints
-- Copyright   : (c) 2013-2014 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

-- | This operation lists the recovery points for a specified gateway. This
-- operation is supported only for the gateway-cached volume architecture.
-- Each gateway-cached volume has one recovery point. A volume recovery point
-- is a point in time at which all data of the volume is consistent and from
-- which you can create a snapshot. To create a snapshot from a volume
-- recovery point use the CreateSnapshotFromVolumeRecoveryPoint operation.
module Network.AWS.StorageGateway.ListVolumeRecoveryPoints
    (
    -- * Request
      ListVolumeRecoveryPoints
    -- ** Request constructor
    , listVolumeRecoveryPoints
    -- ** Request lenses
    , lvrpGatewayARN

    -- * Response
    , ListVolumeRecoveryPointsResponse
    -- ** Response constructor
    , listVolumeRecoveryPointsResponse
    -- ** Response lenses
    , lvrprGatewayARN
    , lvrprVolumeRecoveryPointInfos
    ) where

import Network.AWS.Prelude
import Network.AWS.Request
import Network.AWS.StorageGateway.Types

newtype ListVolumeRecoveryPoints = ListVolumeRecoveryPoints
    { _lvrpGatewayARN :: Text
    } deriving (Eq, Ord, Show, Generic, Monoid, IsString)

-- | 'ListVolumeRecoveryPoints' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'lvrpGatewayARN' @::@ 'Text'
--
listVolumeRecoveryPoints :: Text -- ^ 'lvrpGatewayARN'
                         -> ListVolumeRecoveryPoints
listVolumeRecoveryPoints p1 = ListVolumeRecoveryPoints
    { _lvrpGatewayARN = p1
    }

lvrpGatewayARN :: Lens' ListVolumeRecoveryPoints Text
lvrpGatewayARN = lens _lvrpGatewayARN (\s a -> s { _lvrpGatewayARN = a })

instance ToPath ListVolumeRecoveryPoints where
    toPath = const "/"

instance ToQuery ListVolumeRecoveryPoints where
    toQuery = const mempty

instance ToHeaders ListVolumeRecoveryPoints

instance ToBody ListVolumeRecoveryPoints where
    toBody = toBody . encode . _lvrpGatewayARN

data ListVolumeRecoveryPointsResponse = ListVolumeRecoveryPointsResponse
    { _lvrprGatewayARN               :: Maybe Text
    , _lvrprVolumeRecoveryPointInfos :: [VolumeRecoveryPointInfo]
    } deriving (Eq, Show, Generic)

-- | 'ListVolumeRecoveryPointsResponse' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'lvrprGatewayARN' @::@ 'Maybe' 'Text'
--
-- * 'lvrprVolumeRecoveryPointInfos' @::@ ['VolumeRecoveryPointInfo']
--
listVolumeRecoveryPointsResponse :: ListVolumeRecoveryPointsResponse
listVolumeRecoveryPointsResponse = ListVolumeRecoveryPointsResponse
    { _lvrprGatewayARN               = Nothing
    , _lvrprVolumeRecoveryPointInfos = mempty
    }

lvrprGatewayARN :: Lens' ListVolumeRecoveryPointsResponse (Maybe Text)
lvrprGatewayARN = lens _lvrprGatewayARN (\s a -> s { _lvrprGatewayARN = a })

lvrprVolumeRecoveryPointInfos :: Lens' ListVolumeRecoveryPointsResponse [VolumeRecoveryPointInfo]
lvrprVolumeRecoveryPointInfos =
    lens _lvrprVolumeRecoveryPointInfos
        (\s a -> s { _lvrprVolumeRecoveryPointInfos = a })

-- FromJSON

instance AWSRequest ListVolumeRecoveryPoints where
    type Sv ListVolumeRecoveryPoints = StorageGateway
    type Rs ListVolumeRecoveryPoints = ListVolumeRecoveryPointsResponse

    request  = post'
    response = jsonResponse $ \h o -> ListVolumeRecoveryPointsResponse
        <$> o .: "GatewayARN"
        <*> o .: "VolumeRecoveryPointInfos"
