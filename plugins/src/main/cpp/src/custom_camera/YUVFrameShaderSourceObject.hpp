/******************************************************************************
 * File: YUVFrameShaderSourceObject.hpp
 * Copyright (c) 2021 Qualcomm Technologies, Inc. and/or its subsidiaries. All rights reserved.
 *  2016-2021 Wikitude GmbH.
 * 
 * Confidential and Proprietary - Qualcomm Technologies, Inc.
 *
 ******************************************************************************/

#ifndef YUVFrameShaderSourceObject_hpp
#define YUVFrameShaderSourceObject_hpp

#include <string>
#include <vector>


class YUVFrameShaderSourceObject {
public:
    YUVFrameShaderSourceObject();
    virtual ~YUVFrameShaderSourceObject();

    virtual std::string getVertexShaderSource() const;
    virtual std::string getFragmentShaderSource() const;

    virtual std::string getVertexPositionAttributeName() const;
    virtual std::string getTextureCoordinateAttributeName() const;

    virtual std::vector<std::string> getTextureUniformNames() const;
};

#endif /* YUVFrameShaderSourceObject_hpp */
