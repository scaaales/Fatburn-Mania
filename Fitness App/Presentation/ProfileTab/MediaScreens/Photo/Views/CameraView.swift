//
//  PhotoPreviewView.swift
//  Fitness App
//
//  Created by scales on 1/16/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit
import AVKit

class CameraView: UIView {

	override class var layerClass: AnyClass {
		return AVCaptureVideoPreviewLayer.self
	}

	/// Convenience wrapper to get layer as its statically known type.
	var videoPreviewLayer: AVCaptureVideoPreviewLayer {
		let result = layer as! AVCaptureVideoPreviewLayer
		result.videoGravity = .resizeAspectFill
		layer.masksToBounds = true
		return result
	}

}
