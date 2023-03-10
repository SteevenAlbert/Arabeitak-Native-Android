/******************************************************************************
 * File: BarcodeScannerJavaScriptPluginModule.cpp
 * Copyright (c) 2021 Qualcomm Technologies, Inc. and/or its subsidiaries. All rights reserved.
 *  2018-2021 Wikitude GmbH.
 * 
 * Confidential and Proprietary - Qualcomm Technologies, Inc.
 *
 ******************************************************************************/

#include "BarcodeScannerJavaScriptPluginModule.hpp"

#include <sstream>


BarcodeScannerJavaScriptPluginModule::BarcodeScannerJavaScriptPluginModule(CreateBarcodeScannerHandle createBarcodeScannerHandle_)
:
_createBarcodeScannerHandle(createBarcodeScannerHandle_)
{ /* Intentionally Left Blank */ }

/* From JavaScriptPluginModule */
BarcodeScannerJavaScriptPluginModule::JavaScriptAPI BarcodeScannerJavaScriptPluginModule::getJavaScriptAPI() {
    return {
        R"(
            class BarcodeScanner {
                constructor(options) {
                    this.id = AR.plugins.createInstance("com.wikitude.plugins.barcode_scanner_demo", this, {});

                    options = options != undefined ? options : {};
                    this.onBarcodeRecognized = options.onBarcodeRecognized ? options.onBarcodeRecognized : undefined;
                    this.onBarcodeLost = options.onBarcodeLost ? options.onBarcodeLost : undefined;
                }

                _barcodeRecognized(barcode) {
                    if ( this.onBarcodeRecognized != undefined ) {
                        this.onBarcodeRecognized(barcode);
                    }
                }

                _barcodeLost() {
                    if ( this.onBarcodeLost != undefined ) {
                        this.onBarcodeLost();
                    }
                }
            };
        )",
        { /* Intentionally Left Blank */ }
    };
}

void BarcodeScannerJavaScriptPluginModule::createInstance(const std::string& /* className_ */, long id_, const std::string& /* parameter_ */) {
    _createBarcodeScannerHandle(id_);
}

void BarcodeScannerJavaScriptPluginModule::callBarcodeRecognizedCallback(long id_, const std::string& barcode_) {
    callInstance(id_, "_barcodeRecognized(\"" + barcode_ + "\");");
}

void BarcodeScannerJavaScriptPluginModule::callBarcodeLostCallback(long id_) {
    callInstance(id_, "_barcodeLost();");
}
