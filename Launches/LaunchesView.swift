//
//  LaunchesView.swift
//  Launches
//
//  Created by Adrian Tineo on 02.08.20.
//  Copyright © 2020 Matteo Manferdini. All rights reserved.
//

import SwiftUI

struct LaunchesView: View {
	let launches: [Launch]
	
	var body: some View {
		List {
			ForEach(launches) { launch in
				NavigationLink(destination: DetailView(launch: launch)) {
					Row(
						image: launch.patch,
						title: launch.missionName,
						subtitle1: launch.date.formatted,
						subtitle2: launch.succeeded.formatted)
				}
			}
		}
		.navigationBarTitle("Launches")
	}
}

struct LaunchesView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			LaunchesView(launches: TestData.launches)
		}
	}
}
