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
import MdocDataModel18013

public struct CborData {
    public let id: String
    public let iss: IssuerSigned
    public let dpk: CoseKeyPrivate
}

public extension Document {
    
    /// get CBOR data and private key from document
    func getCborData() throws -> CborData {
        switch docDataType {
        case .signupResponseJson:
            guard let sr = data.decodeJSON(type: SignUpResponse.self),
                  let dr = sr.deviceResponse,
                  let iss = dr.documents?.first?.issuerSigned,
                  let dpk = sr.devicePrivateKey else {
                throw StorageError(description: "Could not get CBOR data from signup response JSON")
            }
            let randomId = UUID().uuidString
            return CborData(id: randomId, iss: iss, dpk: dpk)
        case .cbor:
            guard let iss = IssuerSigned(data: [UInt8](data)),
                  let privateKeyType,
                  let privateKey else {
                throw StorageError(description: "Could not get CBOR data for CBOR")
            }
            let dpk = try IssueRequest(id: id,
                                       privateKeyType: privateKeyType,
                                       keyData: privateKey).toCoseKeyPrivate()
            return CborData(id: id, iss: iss, dpk: dpk)
        case .sjwt:
            throw StorageError(description: "Getting CBOR for document based on SDJWT is not implemented")
        }
    }
}
