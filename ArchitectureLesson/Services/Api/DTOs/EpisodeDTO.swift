//
//  EpisodeDTO.swift
//  ArchitectureLesson
//
//  Created by Фомин Александр Андреевич on 02.02.2023.
//

import Foundation

struct EpisodeDTO: Codable {
	let episodeID, episodeNum: String
	let episodeURL: String

	enum CodingKeys: String, CodingKey {
		case episodeID = "episodeId"
		case episodeNum
		case episodeURL = "episodeUrl"
	}
}
