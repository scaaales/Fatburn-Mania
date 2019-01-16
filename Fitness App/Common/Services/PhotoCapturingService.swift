//
//  PhotoCapturingService.swift
//  Fitness App
//
//  Created by scales on 1/16/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit
import AVFoundation

class PhotoCapturingService: NSObject {

	private var captureSession: AVCaptureSession
	private var photoOutput: AVCapturePhotoOutput!
	
	private(set) var isConfigurated = false
	private(set) var isAuthorized = false
	
	private var takePhotoCompletion: ((UIImage) -> Void)?
	
	override init() {
		captureSession = .init()
		super.init()
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
		
		photoOutput = AVCapturePhotoOutput()
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
	
	func takePhoto(previewSize: CGSize, completion: @escaping (UIImage) -> Void) {
		self.takePhotoCompletion = completion
		
		let settings = AVCapturePhotoSettings()
		
		let previewPixelType = settings.availablePreviewPhotoPixelFormatTypes.first!
		let previewFormat = [
			kCVPixelBufferPixelFormatTypeKey as String: previewPixelType,
			kCVPixelBufferWidthKey as String: previewSize.width,
			kCVPixelBufferHeightKey as String: previewSize.height
			] as [String : Any]
		settings.previewPhotoFormat = previewFormat
		
		photoOutput.capturePhoto(with: settings, delegate: self)
	}
	
}

extension PhotoCapturingService: AVCapturePhotoCaptureDelegate {
	func photoOutput(_ captureOutput: AVCapturePhotoOutput,
					 didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?,
					 previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?,
					 resolvedSettings: AVCaptureResolvedPhotoSettings,
					 bracketSettings: AVCaptureBracketedStillImageSettings?,
					 error: Error?) {
		if let error = error {
			print("Capture failed: \(error.localizedDescription)")
		}
		
		if let sampleBuffer = photoSampleBuffer,
			let previewBuffer = previewPhotoSampleBuffer,
			let dataImage =  AVCapturePhotoOutput
				.jpegPhotoDataRepresentation(forJPEGSampleBuffer: sampleBuffer, previewPhotoSampleBuffer: previewBuffer),
			let dataProvider = CGDataProvider(data: dataImage as CFData),
			let cgImageRef = CGImage(jpegDataProviderSource: dataProvider, decode: nil, shouldInterpolate: true, intent: .defaultIntent) {
			let image = UIImage(cgImage: cgImageRef, scale: 1, orientation: .right)
			takePhotoCompletion?(image)
		}
	}
}
