/******************************************************************************
 * File: BarcodeScanner.cpp
 * Copyright (c) 2021 Qualcomm Technologies, Inc. and/or its subsidiaries. All rights reserved.
 *  2018-2021 Wikitude GmbH.
 * 
 * Confidential and Proprietary - Qualcomm Technologies, Inc.
 *
 ******************************************************************************/

#include "BarcodeScanner.hpp"

#ifdef INCLUDE_WIKITUDE_AS_USER_HEADER
    #include "ManagedCameraFrame.hpp"
#else
    #import <WikitudeSDK/ManagedCameraFrame.hpp>
#endif


BarcodeScanner::BarcodeScanner(long id_, Observer& observer_)
:
_id(id_),
_observer(observer_),
_numberOfPreviouslyRecognizedTargets(0)
{
    _imageScanner.set_config(zbar::ZBAR_NONE, zbar::ZBAR_CFG_ENABLE, 1);
}

BarcodeScanner::~BarcodeScanner() {
    _image.set_data(nullptr, 0);
}

void BarcodeScanner::processCameraFrame(wikitude::sdk::ManagedCameraFrame& managedCameraFrame_) {
    if ( _image.get_width() == 0 && _image.get_height() == 0 ) {
        _image.set_size(static_cast<unsigned int>(managedCameraFrame_.getColorMetadata().getPixelSize().width), static_cast<unsigned int>(managedCameraFrame_.getColorMetadata().getPixelSize().height));
        _image.set_format("Y800");
    }

    const wikitude::sdk::CameraFramePlane& luminancePlane = managedCameraFrame_.get()[0];
    _image.set_data(luminancePlane.getData(), luminancePlane.getDataSize());

    int numberOfRecognizedTargets = _imageScanner.scan(_image);
    if ( numberOfRecognizedTargets != _numberOfPreviouslyRecognizedTargets ) {
        if ( numberOfRecognizedTargets > 0 ) {
            zbar::Image::SymbolIterator symbol = _image.symbol_begin();
            _observer.recognizedBarcode(_id, symbol->get_data());
        } else {
            _observer.lostBarcode(_id);
        }
    }
    _numberOfPreviouslyRecognizedTargets = numberOfRecognizedTargets;
}
