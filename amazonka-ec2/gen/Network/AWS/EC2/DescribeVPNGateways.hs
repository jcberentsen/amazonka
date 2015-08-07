{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE OverloadedStrings  #-}
{-# LANGUAGE RecordWildCards    #-}
{-# LANGUAGE TypeFamilies       #-}

{-# OPTIONS_GHC -fno-warn-unused-binds   #-}
{-# OPTIONS_GHC -fno-warn-unused-matches #-}

-- Derived from AWS service descriptions, licensed under Apache 2.0.

-- |
-- Module      : Network.AWS.EC2.DescribeVPNGateways
-- Copyright   : (c) 2013-2015 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)
--
-- Describes one or more of your virtual private gateways.
--
-- For more information about virtual private gateways, see
-- <http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_VPN.html Adding an IPsec Hardware VPN to Your VPC>
-- in the /Amazon Virtual Private Cloud User Guide/.
--
-- <http://docs.aws.amazon.com/AWSEC2/latest/APIReference/ApiReference-query-DescribeVPNGateways.html>
module Network.AWS.EC2.DescribeVPNGateways
    (
    -- * Request
      DescribeVPNGateways
    -- ** Request constructor
    , describeVPNGateways
    -- ** Request lenses
    , dvgsFilters
    , dvgsDryRun
    , dvgsVPNGatewayIds

    -- * Response
    , DescribeVPNGatewaysResponse
    -- ** Response constructor
    , describeVPNGatewaysResponse
    -- ** Response lenses
    , dvgrsVPNGateways
    , dvgrsStatus
    ) where

import           Network.AWS.EC2.Types
import           Network.AWS.Prelude
import           Network.AWS.Request
import           Network.AWS.Response

-- | /See:/ 'describeVPNGateways' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'dvgsFilters'
--
-- * 'dvgsDryRun'
--
-- * 'dvgsVPNGatewayIds'
data DescribeVPNGateways = DescribeVPNGateways'
    { _dvgsFilters       :: !(Maybe [Filter])
    , _dvgsDryRun        :: !(Maybe Bool)
    , _dvgsVPNGatewayIds :: !(Maybe [Text])
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'DescribeVPNGateways' smart constructor.
describeVPNGateways :: DescribeVPNGateways
describeVPNGateways =
    DescribeVPNGateways'
    { _dvgsFilters = Nothing
    , _dvgsDryRun = Nothing
    , _dvgsVPNGatewayIds = Nothing
    }

-- | One or more filters.
--
-- -   @attachment.state@ - The current state of the attachment between the
--     gateway and the VPC (@attaching@ | @attached@ | @detaching@ |
--     @detached@).
--
-- -   @attachment.vpc-id@ - The ID of an attached VPC.
--
-- -   @availability-zone@ - The Availability Zone for the virtual private
--     gateway.
--
-- -   @state@ - The state of the virtual private gateway (@pending@ |
--     @available@ | @deleting@ | @deleted@).
--
-- -   @tag@:/key/=/value/ - The key\/value combination of a tag assigned
--     to the resource.
--
-- -   @tag-key@ - The key of a tag assigned to the resource. This filter
--     is independent of the @tag-value@ filter. For example, if you use
--     both the filter \"tag-key=Purpose\" and the filter \"tag-value=X\",
--     you get any resources assigned both the tag key Purpose (regardless
--     of what the tag\'s value is), and the tag value X (regardless of
--     what the tag\'s key is). If you want to list only resources where
--     Purpose is X, see the @tag@:/key/=/value/ filter.
--
-- -   @tag-value@ - The value of a tag assigned to the resource. This
--     filter is independent of the @tag-key@ filter.
--
-- -   @type@ - The type of virtual private gateway. Currently the only
--     supported type is @ipsec.1@.
--
-- -   @vpn-gateway-id@ - The ID of the virtual private gateway.
--
dvgsFilters :: Lens' DescribeVPNGateways [Filter]
dvgsFilters = lens _dvgsFilters (\ s a -> s{_dvgsFilters = a}) . _Default . _Coerce;

-- | Checks whether you have the required permissions for the action, without
-- actually making the request, and provides an error response. If you have
-- the required permissions, the error response is @DryRunOperation@.
-- Otherwise, it is @UnauthorizedOperation@.
dvgsDryRun :: Lens' DescribeVPNGateways (Maybe Bool)
dvgsDryRun = lens _dvgsDryRun (\ s a -> s{_dvgsDryRun = a});

-- | One or more virtual private gateway IDs.
--
-- Default: Describes all your virtual private gateways.
dvgsVPNGatewayIds :: Lens' DescribeVPNGateways [Text]
dvgsVPNGatewayIds = lens _dvgsVPNGatewayIds (\ s a -> s{_dvgsVPNGatewayIds = a}) . _Default . _Coerce;

instance AWSRequest DescribeVPNGateways where
        type Sv DescribeVPNGateways = EC2
        type Rs DescribeVPNGateways =
             DescribeVPNGatewaysResponse
        request = post
        response
          = receiveXML
              (\ s h x ->
                 DescribeVPNGatewaysResponse' <$>
                   (x .@? "vpnGatewaySet" .!@ mempty >>=
                      may (parseXMLList "item"))
                     <*> (pure (fromEnum s)))

instance ToHeaders DescribeVPNGateways where
        toHeaders = const mempty

instance ToPath DescribeVPNGateways where
        toPath = const "/"

instance ToQuery DescribeVPNGateways where
        toQuery DescribeVPNGateways'{..}
          = mconcat
              ["Action" =: ("DescribeVpnGateways" :: ByteString),
               "Version" =: ("2015-04-15" :: ByteString),
               toQuery (toQueryList "Filter" <$> _dvgsFilters),
               "DryRun" =: _dvgsDryRun,
               toQuery
                 (toQueryList "VpnGatewayId" <$> _dvgsVPNGatewayIds)]

-- | /See:/ 'describeVPNGatewaysResponse' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'dvgrsVPNGateways'
--
-- * 'dvgrsStatus'
data DescribeVPNGatewaysResponse = DescribeVPNGatewaysResponse'
    { _dvgrsVPNGateways :: !(Maybe [VPNGateway])
    , _dvgrsStatus      :: !Int
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'DescribeVPNGatewaysResponse' smart constructor.
describeVPNGatewaysResponse :: Int -> DescribeVPNGatewaysResponse
describeVPNGatewaysResponse pStatus_ =
    DescribeVPNGatewaysResponse'
    { _dvgrsVPNGateways = Nothing
    , _dvgrsStatus = pStatus_
    }

-- | Information about one or more virtual private gateways.
dvgrsVPNGateways :: Lens' DescribeVPNGatewaysResponse [VPNGateway]
dvgrsVPNGateways = lens _dvgrsVPNGateways (\ s a -> s{_dvgrsVPNGateways = a}) . _Default . _Coerce;

-- | FIXME: Undocumented member.
dvgrsStatus :: Lens' DescribeVPNGatewaysResponse Int
dvgrsStatus = lens _dvgrsStatus (\ s a -> s{_dvgrsStatus = a});