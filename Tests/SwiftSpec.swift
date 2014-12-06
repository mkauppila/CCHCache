//
//  SwiftSpec.swift
//  CCHCache
//
//  Created by Markus Kauppila on 06/12/14.
//

import Foundation
import Nimble
import Quick

// AFAIK this is needed to make Nimble compile
class SwiftSpec: QuickSpec {
    override func spec() {
        expect(true).to(beTruthy())
    }
}
