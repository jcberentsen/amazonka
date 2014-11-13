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

-- Module      : Network.AWS.SimpleWorkflow.RespondActivityTaskCanceled
-- Copyright   : (c) 2013-2014 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

-- | Used by workers to tell the service that the ActivityTask identified by the
-- taskToken was successfully canceled. Additional details can be optionally
-- provided using the details argument. These details (if provided) appear in
-- the ActivityTaskCanceled event added to the workflow history. Only use this
-- operation if the canceled flag of a RecordActivityTaskHeartbeat request
-- returns true and if the activity can be safely undone or abandoned. A task
-- is considered open from the time that it is scheduled until it is closed.
-- Therefore a task is reported as open while a worker is processing it. A
-- task is closed after it has been specified in a call to
-- RespondActivityTaskCompleted, RespondActivityTaskCanceled,
-- RespondActivityTaskFailed, or the task has timed out. Access Control You
-- can use IAM policies to control this action's access to Amazon SWF
-- resources as follows: Use a Resource element with the domain name to limit
-- the action to only specified domains. Use an Action element to allow or
-- deny permission to call this action. You cannot use an IAM policy to
-- constrain this action's parameters. If the caller does not have sufficient
-- permissions to invoke the action, or the parameter values fall outside the
-- specified constraints, the action fails by throwing OperationNotPermitted.
-- For details and example IAM policies, see Using IAM to Manage Access to
-- Amazon SWF Workflows.
module Network.AWS.SimpleWorkflow.RespondActivityTaskCanceled
    (
    -- * Request
      RespondActivityTaskCanceled
    -- ** Request constructor
    , respondActivityTaskCanceled
    -- ** Request lenses
    , ratc1Details
    , ratc1TaskToken

    -- * Response
    , RespondActivityTaskCanceledResponse
    -- ** Response constructor
    , respondActivityTaskCanceledResponse
    ) where

import Network.AWS.Prelude
import Network.AWS.Request
import Network.AWS.SimpleWorkflow.Types

data RespondActivityTaskCanceled = RespondActivityTaskCanceled
    { _ratc1Details   :: Maybe Text
    , _ratc1TaskToken :: Text
    } deriving (Eq, Ord, Show, Generic)

-- | 'RespondActivityTaskCanceled' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'ratc1Details' @::@ 'Maybe' 'Text'
--
-- * 'ratc1TaskToken' @::@ 'Text'
--
respondActivityTaskCanceled :: Text -- ^ 'ratc1TaskToken'
                            -> RespondActivityTaskCanceled
respondActivityTaskCanceled p1 = RespondActivityTaskCanceled
    { _ratc1TaskToken = p1
    , _ratc1Details   = Nothing
    }

-- | Optional information about the cancellation.
ratc1Details :: Lens' RespondActivityTaskCanceled (Maybe Text)
ratc1Details = lens _ratc1Details (\s a -> s { _ratc1Details = a })

-- | The taskToken of the ActivityTask. The taskToken is generated by the
-- service and should be treated as an opaque value. If the task is passed
-- to another process, its taskToken must also be passed. This enables it to
-- provide its progress and respond with results.
ratc1TaskToken :: Lens' RespondActivityTaskCanceled Text
ratc1TaskToken = lens _ratc1TaskToken (\s a -> s { _ratc1TaskToken = a })

instance ToPath RespondActivityTaskCanceled where
    toPath = const "/"

instance ToQuery RespondActivityTaskCanceled where
    toQuery = const mempty

instance ToHeaders RespondActivityTaskCanceled

instance ToBody RespondActivityTaskCanceled where
    toBody = toBody . encode . _ratc1TaskToken

data RespondActivityTaskCanceledResponse = RespondActivityTaskCanceledResponse
    deriving (Eq, Ord, Show, Generic)

-- | 'RespondActivityTaskCanceledResponse' constructor.
respondActivityTaskCanceledResponse :: RespondActivityTaskCanceledResponse
respondActivityTaskCanceledResponse = RespondActivityTaskCanceledResponse

-- FromJSON

instance AWSRequest RespondActivityTaskCanceled where
    type Sv RespondActivityTaskCanceled = SimpleWorkflow
    type Rs RespondActivityTaskCanceled = RespondActivityTaskCanceledResponse

    request  = post'
    response = nullaryResponse RespondActivityTaskCanceledResponse
