//
//  PopularAnimeElementDTO.swift
//  ArchitectureLesson
//
//  Created by Фомин Александр Андреевич on 02.02.2023.
//

import Foundation

struct PopularAnimeElementDTO: Codable {
	let animeID, animeTitle: String
	let animeImg: String
	let releasedDate: String
	let animeURL: String

	enum CodingKeys: String, CodingKey {
		case animeID = "animeId"
		case animeTitle, animeImg, releasedDate
		case animeURL = "animeUrl"
	}
}
