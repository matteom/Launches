//
//  LaunchInfoView.swift
//  Launches
//
//  Created by Adrian Tineo on 07.08.20.
//  Copyright © 2020 Matteo Manferdini. All rights reserved.
//

import SwiftUI

struct Row: View {
	let image: UIImage?
	let title: String
	let subtitle1: String
	let subtitle2: String
	
	var body: some View {
		HStack(spacing: 16.0) {
			Image(uiImage: image ?? UIImage())
				.resizable()
				.frame(width: 62.0, height: 62.0)
			VStack(alignment: .leading, spacing: 2.0) {
				Text(title)
					.font(.headline)
				Group {
					Text(subtitle1)
					Text(subtitle2)
				}
				.font(.subheadline)
				.foregroundColor(.gray)
			}
		}
		.padding(.vertical, 16.0)
	}
}

struct LaunchInfoView_Previews: PreviewProvider {
	static let launch = TestData.launches[0]
	
	static var previews: some View {
		Row(image: launch.patch,
			title: launch.missionName,
			subtitle1: launch.date.formatted,
			subtitle2: launch.succeeded.formatted)
			.padding()
			.previewLayout(.sizeThatFits)
	}
}
