/******************************************************************************
 * File: Marker.hpp
 * Copyright (c) 2021 Qualcomm Technologies, Inc. and/or its subsidiaries. All rights reserved.
 *  2018-2021 Wikitude GmbH.
 * 
 * Confidential and Proprietary - Qualcomm Technologies, Inc.
 *
 ******************************************************************************/

#ifndef Marker_hpp
#define Marker_hpp

#include <unordered_map>

#ifdef INCLUDE_WIKITUDE_AS_USER_HEADER
    #include "Matrix4.hpp"
#else
    #import <WikitudeSDK/Matrix4.hpp>
#endif


namespace demo {
    class Marker {
    public:
        Marker(int id_, wikitude::sdk::Matrix4& matrix_)
        :
        _id(id_),
        _matrix(matrix_)
        {}
        
        int                     _id;
        wikitude::sdk::Matrix4  _matrix;
    };

    enum class PositionableState {
        Recognized,
        Tracking,
        Lost
    };

    class PositionableData {
    public:
        PositionableData(long trackableId_, PositionableState state_, int markerId_, wikitude::sdk::Matrix4& matrix_)
        :
        _trackableId(trackableId_),
        _state(state_),
        _marker(markerId_, matrix_)
        {}
        
        long                _trackableId;
        PositionableState   _state;
        Marker              _marker;
    };
}

#endif /* Marker_hpp */
