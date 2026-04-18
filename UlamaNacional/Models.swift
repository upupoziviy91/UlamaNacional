import Foundation
import SwiftUI

struct RuleCard: Identifiable {
    var id: String { title }
    let title: String
    let detail: String
    let systemImage: String
}

struct Drill: Identifiable {
    var id: String { title }
    let title: String
    let duration: String
    let focus: String
    let steps: [String]
    let color: Color
}

struct Venue: Identifiable {
    var id: String { "\(city)-\(country)-\(tag)" }
    let city: String
    let country: String
    let note: String
    let tag: String
}

struct InfoTopic: Identifiable {
    var id: String { title }
    let title: String
    let detail: String
    let tag: String
    let systemImage: String
}

struct HistoryItem: Identifiable {
    var id: String { "\(period)-\(title)" }
    let period: String
    let title: String
    let detail: String
    let systemImage: String
}

struct CultureNote: Identifiable {
    var id: String { title }
    let title: String
    let detail: String
    let tag: String
}

struct GlossaryTerm: Identifiable {
    var id: String { term }
    let term: String
    let meaning: String
}

struct QuizQuestion: Identifiable {
    var id: String { prompt }
    let prompt: String
    let options: [String]
    let correctIndex: Int
    let explanation: String
}

struct MatchLog: Identifiable, Codable, Equatable {
    let id: UUID
    let date: Date
    let homeName: String
    let awayName: String
    let homeScore: Int
    let awayScore: Int

    func winner(language: AppLanguage) -> String {
        if homeScore == awayScore { return Copy.tie(language) }
        return homeScore > awayScore ? homeName : awayName
    }
}

struct ScoreState: Codable, Equatable {
    var homeName = "Jaguar"
    var awayName = "Ceiba"
    var homeScore = 0
    var awayScore = 0
    var rallies = 0
    var targetScore = 15
    var servingHome = true
    var pointHistory: [Bool] = []

    enum CodingKeys: String, CodingKey {
        case homeName
        case awayName
        case homeScore
        case awayScore
        case rallies
        case targetScore
        case servingHome
        case pointHistory
    }

    init() {}

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        homeName = try container.decodeIfPresent(String.self, forKey: .homeName) ?? "Jaguar"
        awayName = try container.decodeIfPresent(String.self, forKey: .awayName) ?? "Ceiba"
        homeScore = try container.decodeIfPresent(Int.self, forKey: .homeScore) ?? 0
        awayScore = try container.decodeIfPresent(Int.self, forKey: .awayScore) ?? 0
        rallies = try container.decodeIfPresent(Int.self, forKey: .rallies) ?? 0
        targetScore = try container.decodeIfPresent(Int.self, forKey: .targetScore) ?? 15
        servingHome = try container.decodeIfPresent(Bool.self, forKey: .servingHome) ?? true
        pointHistory = try container.decodeIfPresent([Bool].self, forKey: .pointHistory) ?? []
    }
}
