/******************************************************************************
 * File: FaceTrackerJavaScriptPluginModule.hpp
 * Copyright (c) 2021 Qualcomm Technologies, Inc. and/or its subsidiaries. All rights reserved.
 *  2018-2021 Wikitude GmbH.
 * 
 * Confidential and Proprietary - Qualcomm Technologies, Inc.
 *
 ******************************************************************************/

#ifndef FaceTrackerJavaScriptPluginModule_hpp
#define FaceTrackerJavaScriptPluginModule_hpp

#ifdef INCLUDE_WIKITUDE_AS_USER_HEADER
    #include "JavaScriptPluginModule.hpp"
#else
    #import <WikitudeSDK/JavaScriptPluginModule.hpp>
#endif

#include "FaceTracker.hpp"


class FaceTrackerJavaScriptPluginModule : public wikitude::sdk::JavaScriptPluginModule {
public:
    FaceTrackerJavaScriptPluginModule(wikitude::sdk::RuntimeParameters* runtimeParameters_, std::unordered_map<long, std::unique_ptr<FaceTracker>>& registeredFaceTracker_, const std::string& temporaryDirectory_);

    JavaScriptPluginModule::JavaScriptAPI getJavaScriptAPI() override;
    void createInstance(const std::string& className_, long id_, const std::string& parameter_) override;

protected:
    wikitude::sdk::RuntimeParameters*                           _runtimeParameters;
    std::unordered_map<long, std::unique_ptr<FaceTracker>>&     _registeredFaceTracker;
    std::string                                                 _temporaryDirectory;
};

#endif /* FaceTrackerJavaScriptPluginModule_hpp */
