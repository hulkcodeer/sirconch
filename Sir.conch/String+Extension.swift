//
//  File.swift
//  Sir.conch
//
//  Created by 박현진 on 7/25/24.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
