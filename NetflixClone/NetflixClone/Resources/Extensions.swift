//
//  Extensions.swift
//  NetflixClone
//
//  Created by AMAR on 01/01/24.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String{
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
