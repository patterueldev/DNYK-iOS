//
//  DNYKService.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/10/23.
//

import Foundation

protocol DNYKService {
    func addTransaction(_ transaction: TransactionObject) async
}

protocol TransactionObject {
    
}
