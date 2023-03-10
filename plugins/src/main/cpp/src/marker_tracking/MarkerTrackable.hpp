/******************************************************************************
 * File: MarkerTrackable.hpp
 * Copyright (c) 2021 Qualcomm Technologies, Inc. and/or its subsidiaries. All rights reserved.
 *  2018-2021 Wikitude GmbH.
 * 
 * Confidential and Proprietary - Qualcomm Technologies, Inc.
 *
 ******************************************************************************/

#ifndef MarkerTrackable_hpp
#define MarkerTrackable_hpp

#include <string>
#include <vector>
#include <unordered_map>

#include "Marker.hpp"


class MarkerTrackerJavaScriptPluginModule;
class MarkerTrackable {
public:
    enum class State {
        Recognition,
        Tracking,
        Lost
    };

public:
    MarkerTrackable(long id_, long markerTrackerId_, int markerId_);
    
    void processTrackedMarker(int markerId_, wikitude::sdk::Matrix4& matrix_, std::unordered_map<std::string, demo::PositionableData>& positionableData_);
    void cleanupRecentMarkers(int markerId_, std::unordered_map<std::string, demo::PositionableData>& positionableData_);
    
protected:
    long        _id;
    long        _markerTrackerId;
    int         _markerId;
    
    const std::string   _positionableId;
    
    State       _state;
};

#endif /* MarkerTrackable_hpp */
