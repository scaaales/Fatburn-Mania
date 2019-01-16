//
//  PhotoView.swift
//  Fitness App
//
//  Created by scales on 1/16/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import AVKit

protocol PhotoView: View {
	var videoPreviewLayer: AVCaptureVideoPreviewLayer { get }
}
