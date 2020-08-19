//
//  NeworkController.swift
//  Launches
//
//  Created by Matteo Manferdini on 02/09/2020.
//  Copyright © 2020 Matteo Manferdini. All rights reserved.
//

import Foundation
import UIKit

class NetworkController: ObservableObject {
	@Published var launches: [Launch] = []
	
	func fetchLaunches() {
		let url = URL(string: "https://api.spacexdata.com/v3/launches?limit=10")!
		let request = NetworkRequest(url: url)
		request.execute { [weak self] (data) in
			if let data = data {
				self?.decode(data)
			}
		}
	}
}

private extension NetworkController {
	func decode(_ data: Data) {
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .formatted(DateFormatter.fullISO8601)
		launches = (try? decoder.decode([Launch].self, from: data)) ?? []
		for launch in launches {
			fetchPatch(for: launch)
		}
	}
	
	func fetchPatch(for launch: Launch) {
		let request = NetworkRequest(url: launch.patchURL)
		request.execute { [weak self] (data) in
			guard let data = data else { return }
			guard let index = self?.launches.firstIndex(where: { $0.id == launch.id }) else { return }
			self?.launches[index].patch = UIImage(data: data)
		}
	}
}
