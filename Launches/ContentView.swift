//
//  ContentView.swift
//  Launches
//
//  Created by Matteo Manferdini on 03/09/2020.
//  Copyright © 2020 Matteo Manferdini. All rights reserved.
//

import SwiftUI

struct ContentView: View {
	@EnvironmentObject private var networkController: NetworkController

    var body: some View {
		NavigationView {
			LaunchesView(launches: networkController.launches)
		}
		.onAppear(perform: networkController.fetchLaunches)
    }
}
