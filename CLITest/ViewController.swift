//
//  ViewController.swift
//  CLITest
//
//  Created by Paul Wilkinson on 22/9/18.
//  Copyright © 2018 Paul Wilkinson. All rights reserved.
//

import UIKit
import CallKit

class ViewController: UIViewController {
	
	@IBOutlet weak var statusLabel: UILabel!
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.updateExtensionState()
	}

	func updateExtensionState() {
		CXCallDirectoryManager.sharedInstance.getEnabledStatusForExtension(withIdentifier: "me.wilko.CLITest.CLITestCX") { (status, error) in
			guard error == nil else {
				print(error!.localizedDescription)
				return
			}
			
			
			DispatchQueue.main.async {
				
				
				switch status {
					
				case .unknown:
					self.statusLabel.text = NSLocalizedString("Caller identification status is unknown",comment: "caller ID unknown")
					
				case .enabled:
					self.statusLabel.text = NSLocalizedString("Caller identification is enabled",comment: "caller ID enabled")
					
					
				case .disabled:
					self.statusLabel.text = NSLocalizedString("Caller identification is disabled",comment: "called ID disabled")
				}
			}
		}
	}
	
	@IBAction func reload(_ sender: Any) {
		CXCallDirectoryManager.sharedInstance.reloadExtension(withIdentifier: "me.wilko.CLITest.CLITestCX") { (error) in
			if let error = error {
				print(error.localizedDescription)
			}
			self.updateExtensionState()
		}
	}
	
}

