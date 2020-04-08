//
//  ViewController.swift
//  VideoRecorder
//
//  Created by Paul Solt on 10/2/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		// TODO: get permission
		
        requestPermissionAndShowCamera()
        
		showCamera()
		
	}
    
    private func requestPermissionAndShowCamera() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch status {
            case .notDetermined:  // 1st run and the user hasn't been asked to give permission
            requestPermission()
            case .restricted:  // Parental controls limit access to video
            fatalError("You don't have permission to use the camera, talk to your parent about enabling")
            case .denied:
            fatalError("Show them a link to settings to get access to video")
            // 2nd + run, the user didn't trust us, or they said no by accident( show how to enable)
            case .authorized: //2nd + run, they've given permission to use the camera
            showCamera()
            @unknown default:
            fatalError("Didn't ")
        }
        
    }
    
    private func requestPermission() {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            guard granted else { fatalError("Tell user they need to get video permission") }
            DispatchQueue.main.async {
                self.showCamera()
            }
        }
    }
    
	
	private func showCamera() {
		performSegue(withIdentifier: "ShowCamera", sender: self)
	}
}
