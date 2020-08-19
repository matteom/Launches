//
//  TestData.swift
//  Launches
//
//  Created by Adrian Tineo on 02.08.20.
//  Copyright © 2020 Matteo Manferdini. All rights reserved.
//

import Foundation
import UIKit

struct TestData {
	static var launches: [Launch] = {
		let url = Bundle.main.url(forResource: "Launches", withExtension: "json")!
		let data = try! Data(contentsOf: url)
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .formatted(DateFormatter.fullISO8601)
		var launches = try! decoder.decode([Launch].self, from: data)
		for (index, var launch) in launches.enumerated() {
			launch.patch = UIImage(named: "\(launch.id)")
			launches[index] = launch
		}
		return launches
	}()
}
