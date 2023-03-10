/******************************************************************************
 * File: BarcodePlugin.h
 * Copyright (c) 2021 Qualcomm Technologies, Inc. and/or its subsidiaries. All rights reserved.
 *  2015-2021 Wikitude GmbH.
 * 
 * Confidential and Proprietary - Qualcomm Technologies, Inc.
 *
 ******************************************************************************/

#ifndef __BarCodePlugin__
#define __BarCodePlugin__

#ifdef INCLUDE_WIKITUDE_AS_USER_HEADER
    #include "ArchitectPlugin.hpp"
#else
    #import <WikitudeSDK/ArchitectPlugin.hpp>
#endif

#include "BarcodeScanner.hpp"


class BarcodeScannerJavaScriptPluginModule;
class BarcodePlugin : public wikitude::sdk::ArchitectPlugin, public BarcodeScanner::Observer {
public:
    BarcodePlugin();
    virtual ~BarcodePlugin() = default;

    /* From ArchitectPlugin */
    void cameraFrameAvailable(wikitude::sdk::ManagedCameraFrame& managedCameraFrame_) override;

    /* From BarcodeScanner::Observer */
    void recognizedBarcode(long id_, const std::string& barcode_) override;
    void lostBarcode(long id_) override;

protected:
    BarcodeScannerJavaScriptPluginModule* getJavaScriptPluginModule();

protected:
    std::unordered_map<long, std::unique_ptr<BarcodeScanner>>   _registeredBarcodeScanner;
};

#endif /* defined(__BarcodePlugin__) */
