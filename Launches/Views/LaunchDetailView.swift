//
//  DetailView.swift
//  Launches
//
//  Created by Adrian Tineo on 09.08.20.
//  Copyright © 2020 Matteo Manferdini. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    @State var launch: Launch
    @State var hasFetchedImage: Bool = false
    
    var body: some View {
        List {
            LaunchHeaderView(patchImage: hasFetchedImage ? launch.patch : UIImage(),
                             missionTitle: launch.missionName,
                             date: launch.date.formatted,
							 succeeded: launch.succeeded.formatted)
				.frame(maxWidth: .infinity)

            
            LaunchInfoView(patchImage: #imageLiteral(resourceName: "Payload"),
                           title: "Payload deployment",
                           subtitle: "Time: \(launch.timeline?.payloadDeploy?.formatted ?? "")",
                status: "Payloads: \(launch.payloads)",
                isDetailInfo: true)
            
            
            LaunchInfoView(patchImage: #imageLiteral(resourceName: "Cutoff"),
                           title: "Main Engine Cutoff",
                           subtitle: "Time: \(launch.timeline?.mainEngineCutoff?.formatted ?? "")",
                status: "",
                isDetailInfo: true)
            
            LaunchInfoView(patchImage: #imageLiteral(resourceName: "Liftoff"),
                           title: "Liftoff",
                           subtitle: "Time: \(launch.timeline?.liftoff?.formatted ?? "")",
                status: "Rocket: \(launch.rocket)",
                isDetailInfo: true)
            
            LaunchInfoView(patchImage: #imageLiteral(resourceName: "Loading"),
                           title: "Propellant Loading",
                           subtitle: "Time: \(launch.timeline?.propellerLoading?.formatted ?? "")",
                status: "Location: \(launch.site)",
                isDetailInfo: true)
            
        }
        .navigationBarTitle("Launch details", displayMode: .inline)
        .onAppear(perform: fetchLaunch)
    }
}

private extension DetailView {
    
    func fetchLaunch() {
        let url = URL(string: "https://api.spacexdata.com/v3/launches")!
            .appendingPathComponent("\(launch.id)")
        let request = NetworkRequest(url: url)
        request.execute { (data) in
            if let data = data {
                self.decode(data)
            }
        }
    }
    
    func decode(_ data: Data) {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.fullISO8601)
        do {
            launch = try decoder.decode(Launch.self, from: data)
            fetchPatch(url: launch.patchURL)
        } catch {}
    }
    
    
    func fetchPatch(url: URL) {
        let request = NetworkRequest(url: url)
        request.execute { (data) in
            guard let data = data else {
                return
            }
            self.hasFetchedImage = true
            self.launch.patch = UIImage(data: data)
        }
    }
    
}

struct LaunchDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(launch: TestData.launchOne, hasFetchedImage: true)
        }
        .previewWithName("Launch details")
        .frame(height: 800)
    }
}
