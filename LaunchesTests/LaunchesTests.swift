//
//  LaunchesTests.swift
//  LaunchesTests
//
//  Created by Matteo Manferdini on 10/03/2019.
//  Copyright © 2019 Matteo Manferdini. All rights reserved.
//

import XCTest
@testable import Launches

class LaunchesTests: XCTestCase {
    func testLaunchDecoding() {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "Launch", withExtension: "json"),
            let data = try? Data(contentsOf: url) else {
                return
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .secondsSince1970
        guard let launch = try? decoder.decode(Launch.self, from: data) else {
            return
        }
        
        XCTAssertEqual(launch.id, 65)
        XCTAssertEqual(launch.missionName, "Telstar 19V")
        XCTAssertEqual(launch.date, Date(timeIntervalSince1970: 1532238600))
        XCTAssertEqual(launch.succeeded, true)
    }
}
