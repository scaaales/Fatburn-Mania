//
//  PhotoCapturingService.swift
//  Fitness App
//
//  Created by scales on 1/16/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit
import AVFoundation

class PhotoCapturingService {

	private var captureSession: AVCaptureSession
	private(set) var isConfigurated = false
	private(set) var isAuthorized = false
	
	init() {
		captureSession = .init()
	}
	
	func authorizate(completion: @escaping (_ success: Bool) -> Void) {
		switch AVCaptureDevice.authorizationStatus(for: .video) {
		case .authorized: // The user has previously granted access to the camera.
			isAuthorized = true
			completion(true)
			
		case .notDetermined: // The user has not yet been asked for camera access.
			AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
				self?.isAuthorized = granted
				completion(granted)
			}
			
		case .denied: // The user has previously denied access.
			completion(false)
			return
		case .restricted: // The user can't grant access due to restrictions.
			completion(false)
			return
		}
	}
	
	func setupPhotoCapturing() {
		guard !isConfigurated else { return }
		captureSession.beginConfiguration()
		guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else { fatalError() }
		
		guard
			let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice),
			captureSession.canAddInput(videoDeviceInput)
			else { fatalError() }
		captureSession.addInput(videoDeviceInput)
		
		let photoOutput = AVCapturePhotoOutput()
		guard captureSession.canAddOutput(photoOutput) else { fatalError() }
		captureSession.sessionPreset = .photo
		captureSession.addOutput(photoOutput)
		captureSession.commitConfiguration()
		isConfigurated = true
	}
	
	func setVideoPreviewLayer(_ layer: AVCaptureVideoPreviewLayer) {
		if layer.session == nil {
			layer.session = captureSession
		}
	}
	
	func startCapturing() {
		if !captureSession.isRunning {
			captureSession.startRunning()
		}
	}
	
	func endCapturing() {
		if captureSession.isRunning {
			captureSession.stopRunning()
		}
	}
	
}
