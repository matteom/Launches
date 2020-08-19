//
//  DetailView.swift
//  Launches
//
//  Created by Adrian Tineo on 09.08.20.
//  Copyright © 2020 Matteo Manferdini. All rights reserved.
//

import SwiftUI

// MARK: - DetailView
struct DetailView: View {
	let launch: Launch
	
	var payloadDeployment: String { launch.timeline?.payloadDeploy?.formatted ?? "" }
	var mainEngineCutoff: String { launch.timeline?.mainEngineCutoff?.formatted ?? "" }
	var liftoff: String { launch.timeline?.liftoff?.formatted ?? "" }
	var propellerLoading: String { launch.timeline?.propellerLoading?.formatted ?? "" }
	
	var body: some View {
		List {
			Header(launch: launch)
				.frame(maxWidth: .infinity)
			Row(image: #imageLiteral(resourceName: "Payload"),
				title: "Payload Deployment",
				subtitle1: "Time: " + payloadDeployment,
				subtitle2: "Payloads: \(launch.payloads)")
			Row(image: #imageLiteral(resourceName: "Cutoff"),
				title: "Main Engine Cutoff",
				subtitle1: "Time: " + mainEngineCutoff,
				subtitle2: "")
			Row(image: #imageLiteral(resourceName: "Liftoff"),
				title: "Liftoff",
				subtitle1: "Time: " + liftoff,
				subtitle2: "Rocket: \(launch.rocket)")
			Row(image: #imageLiteral(resourceName: "Loading"),
				title: "Propellant Loading",
				subtitle1: "Time: " + propellerLoading,
				subtitle2: "Location: \(launch.site)")
		}
		.navigationBarTitle("Launch details")
	}
}

// MARK: - Header
struct Header: View {
	let launch: Launch
	
	var body: some View {
		VStack(spacing: 24.0) {
			Image(uiImage: launch.patch ?? UIImage())
				.resizable()
				.frame(width: 128.0, height: 128.0)
			VStack(spacing: 8.0) {
				Text(launch.missionName)
					.font(.largeTitle)
					.bold()
				Group {
					Text(launch.date.formatted)
					Text(launch.succeeded.formatted)
				}
				.foregroundColor(.gray)
				.font(.subheadline)
			}
		}
		.padding(.top, 32.0)
		.padding(.bottom, 40.0)
	}
}

// MARK: - Previews
struct LaunchDetailView_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			NavigationView {
				DetailView(launch: TestData.launches[0])
			}
			Header(launch: TestData.launches[0])
				.padding()
				.previewLayout(.sizeThatFits)
		}
	}
}
