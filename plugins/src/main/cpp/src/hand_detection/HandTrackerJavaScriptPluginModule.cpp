/******************************************************************************
 * File: HandTrackerJavaScriptPluginModule.cpp
 * Copyright (c) 2021 Qualcomm Technologies, Inc. and/or its subsidiaries. All rights reserved.
 *  2018-2021 Wikitude GmbH.
 * 
 * Confidential and Proprietary - Qualcomm Technologies, Inc.
 *
 ******************************************************************************/

#include "HandTrackerJavaScriptPluginModule.hpp"

#include <json/json.h>


HandTrackerJavaScriptPluginModule::HandTrackerJavaScriptPluginModule(wikitude::sdk::RuntimeParameters* runtimeParameters_, std::unordered_map<long, std::unique_ptr<HandTracker>>& registeredHandTracker_, const std::string& temporaryDirectory_)
:
_runtimeParameters(runtimeParameters_),
_registeredHandTracker(registeredHandTracker_),
_temporaryDirectory(temporaryDirectory_)
{}

HandTrackerJavaScriptPluginModule::JavaScriptAPI HandTrackerJavaScriptPluginModule::getJavaScriptAPI() {
    return {
        R"(
            class HandTracker {
                constructor(databasePath_, options_) {
                    options_ = options_ != undefined ? options_ : {};
                    this.id = AR.plugins.createInstance("com.wikitude.plugins.hand_tracker_demo", this, {
                        databasePath: AR.__resourceUrl(databasePath_)
                    });

                    this.onError = options_.onError ? options_.onError : undefined;
                }

                _error(error) {
                    if ( this.onError != undefined ) {
                        this.onError(error);
                    }
                }
            };
        )",
        { /* Intentionally Left Blank */ }
    };
}

void HandTrackerJavaScriptPluginModule::createInstance(const std::string& /* className_ */, long id_, const std::string& parameter_) {
    wikitude::external::Json::Value parameterObject;
    wikitude::external::Json::Reader reader(wikitude::external::Json::Features::strictMode());
    if( reader.parse(parameter_, parameterObject) && !parameterObject.isNull() ) {
        std::string databasePath(parameterObject["databasePath"].asString());
        auto emplaceResult = _registeredHandTracker.emplace(id_, std::make_unique<HandTracker>(id_, databasePath, _runtimeParameters, _temporaryDirectory));
        if ( !emplaceResult.first->second->isLoaded() ) {
            callInstance(id_, "_error({code: 1001, message: 'Unable to load given database file ' + '" + databasePath + "'});");
        }
    }
}
