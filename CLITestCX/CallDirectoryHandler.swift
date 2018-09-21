//
//  CallDirectoryHandler.swift
//  CLITestCX
//
//  Created by Paul Wilkinson on 22/9/18.
//  Copyright © 2018 Paul Wilkinson. All rights reserved.
//

import Foundation
import CallKit

class CallDirectoryHandler: CXCallDirectoryProvider {
	
	override func beginRequest(with context: CXCallDirectoryExtensionContext) {
		context.delegate = self
		context.removeAllIdentificationEntries()
		addAllIdentificationPhoneNumbers(to: context)
		
		context.completeRequest()
	}
	
	private func addAllIdentificationPhoneNumbers(to context: CXCallDirectoryExtensionContext) {
		// Retrieve phone numbers to identify and their identification labels from data store. For optimal performance and memory usage when there are many phone numbers,
		// consider only loading a subset of numbers at a given time and using autorelease pool(s) to release objects allocated during each batch of numbers which are loaded.
		//
		// Numbers must be provided in numerically ascending order.
		let allPhoneNumbers: [CXCallDirectoryPhoneNumber] = [ 4412345678 ]
		let labels = [ "CLITest Number" ]
		
		for (phoneNumber, label) in zip(allPhoneNumbers, labels) {
			context.addIdentificationEntry(withNextSequentialPhoneNumber: phoneNumber, label: label)
		}
	}
	
}

extension CallDirectoryHandler: CXCallDirectoryExtensionContextDelegate {
	
	func requestFailed(for extensionContext: CXCallDirectoryExtensionContext, withError error: Error) {
		// An error occurred while adding blocking or identification entries, check the NSError for details.
		// For Call Directory error codes, see the CXErrorCodeCallDirectoryManagerError enum in <CallKit/CXError.h>.
		//
		// This may be used to store the error details in a location accessible by the extension's containing app, so that the
		// app may be notified about errors which occured while loading data even if the request to load data was initiated by
		// the user in Settings instead of via the app itself.
	}
	
}
