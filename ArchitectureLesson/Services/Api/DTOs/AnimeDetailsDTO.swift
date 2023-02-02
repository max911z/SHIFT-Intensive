//
//  AnimeDetailsDTO.swift
//  ArchitectureLesson
//
//  Created by Фомин Александр Андреевич on 02.02.2023.
//

import Foundation

struct AnimeDetailsDTO: Codable {
	let animeTitle, type, releasedDate, status: String
	let genres: [String]
	let otherNames, synopsis: String
	let animeImg: String
	let totalEpisodes: String
	let episodesList: [EpisodeDTO]
}
