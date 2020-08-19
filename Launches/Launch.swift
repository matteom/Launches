//
//  Launch.swift
//  Launches
//
//  Created by Matteo Manferdini on 06/03/2019.
//  Copyright © 2019 Matteo Manferdini. All rights reserved.
//

import Foundation
import UIKit

struct Launch: Identifiable {
	let id: Int
	let missionName: String
//	let launchDateUtc: Date
//	let launchSuccess: Bool
	
	let date: Date
	let succeeded: Bool
	let timeline: Timeline?
	
	let rocket: String
	let site: String
	let patchURL: URL
	let payloads: String
	var patch: UIImage?
}

extension Launch: Decodable {
	enum CodingKeys: String, CodingKey {
		case timeline
		case links
		case rocket
		case id = "flight_number"
		case missionName = "mission_name"
		case date = "launch_date_utc"
		case succeeded = "launch_success"
		case launchSite = "launch_site"
		
		enum RocketKeys: String, CodingKey {
			case rocketName = "rocket_name"
			case secondStage = "second_stage"
			
			enum SecondStageKeys: String, CodingKey {
				case payloads
				
				enum PayloadKeys: String, CodingKey {
					case payloadName = "payload_id"
				}
			}
		}
		
		enum SiteKeys: String, CodingKey {
			case siteName = "site_name_long"
		}
		
		enum LinksKeys: String, CodingKey {
			case patchURL = "mission_patch"
		}
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		id = try container.decode(Int.self, forKey: .id)
		missionName = try container.decode(String.self, forKey: .missionName)
		date = try container.decode(Date.self, forKey: .date)
		succeeded = try container.decode(Bool.self, forKey: .succeeded)
		timeline = try container.decodeIfPresent(Timeline.self, forKey: .timeline)
		
		let linksContainer = try container.nestedContainer(keyedBy: CodingKeys.LinksKeys.self, forKey: .links)
		patchURL = try linksContainer.decode(URL.self, forKey: .patchURL)
		
		let siteContainer = try container.nestedContainer(keyedBy: CodingKeys.SiteKeys.self, forKey: .launchSite)
		site = try siteContainer.decode(String.self, forKey: .siteName)
		
		let rocketContainer = try container.nestedContainer(keyedBy: CodingKeys.RocketKeys.self, forKey: .rocket)
		rocket = try rocketContainer.decode(String.self, forKey: .rocketName)
		let secondStageContainer = try rocketContainer.nestedContainer(keyedBy: CodingKeys.RocketKeys.SecondStageKeys.self, forKey: .secondStage)
		
		var payloadsContainer = try secondStageContainer.nestedUnkeyedContainer(forKey: .payloads)
		var payloads = ""
		while !payloadsContainer.isAtEnd {
			let payloadContainer = try payloadsContainer.nestedContainer(keyedBy: CodingKeys.RocketKeys.SecondStageKeys.PayloadKeys.self)
			let payloadName = try payloadContainer.decode(String.self, forKey: .payloadName)
			payloads += payloads == "" ? payloadName : ", \(payloadName)"
		}
		self.payloads = payloads
	}
}

struct Timeline {
	let propellerLoading: Int?
	let liftoff: Int?
	let mainEngineCutoff: Int?
	let payloadDeploy: Int?
}

extension Timeline: Decodable {
	enum CodingKeys: String, CodingKey {
		case propellerLoading = "go_for_prop_loading"
		case liftoff
		case mainEngineCutoff = "meco"
		case payloadDeploy = "payload_deploy"
	}
}

struct Payload {
	let name: String
}

extension Payload: Decodable {
	enum CodingKeys: String, CodingKey {
		case name = "payload_id"
	}
}
