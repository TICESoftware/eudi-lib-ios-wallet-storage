/*
Copyright (c) 2023 European Commission

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

		http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

import Foundation

/// wallet document structure
public struct Document {
	public init(id: String = UUID().uuidString, docType: String, docDataType: DocDataType, data: Data, privateKeyType: PrivateKeyType?, privateKey: Data?, createdAt: Date?, modifiedAt: Date? = nil, status: DocumentStatus) {
		self.id = id
		self.docType = docType
		self.docDataType = docDataType
		self.data = data
		self.privateKeyType = privateKeyType
		self.privateKey = privateKey
		self.createdAt = createdAt ?? Date()
		self.modifiedAt = modifiedAt
		self.status = status
	}
	
	public var id: String = UUID().uuidString
	public let docType: String
	public let data: Data
	public let docDataType: DocDataType
	public let privateKeyType: PrivateKeyType?
	public let privateKey: Data?
	public let createdAt: Date
	public let modifiedAt: Date?
	public let status: DocumentStatus
	public var isDeferred: Bool { status == .deferred }
}
