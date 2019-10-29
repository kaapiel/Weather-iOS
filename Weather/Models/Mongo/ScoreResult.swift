//   var scoreResult = try? newJSONDecoder().decode(ScoreResult.self, from: jsonData)

import Foundation

struct ScoreResult: Identifiable, Codable {
    var id: Double
    var score: Double
    var duplicationDensity: Double
    var coverage: Double
    var effectiveness: Double
    var applicationName: String
    var totalIssues: Int
    var openIssues: Int
    var openDefects: Int
    var totalDefects: Int
    var testsCase: Int
    var totalTestExecutions: Int
    var totalProblems: Int
    var ncloc: Int
    var issuesBlocker: Int
    var issuesCriticals: Int
    var issuesMajor: Int
    var issuesBug: Int
    var issuesVulnerability: Int
    var issuesCodeSmell: Int
    var executionsPassed: Int
    var averageAge: Double
    var averageTimeFix: Double
    var defectsDensity: Double
    var successRate: Double
    var scoreEffectiveness: Double
    var scoreTotalIssues: Double
    var scoreOpenIssues: Double
    var scoreDuplicationDensity: Double
    var scoreCoverage: Double
    var scoreOpenDefects: Double
    var scoreDefectsDensity: Double
    var scoreAverageAge: Double
    var scoreAverageTimeFix: Double
    var scoreSuccessRate: Double
    var medal: String?
    var iconString: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case applicationName, score, totalIssues, openIssues, duplicationDensity, coverage, openDefects, totalDefects, averageAge, averageTimeFix, effectiveness, scoreTotalIssues, scoreOpenIssues, scoreDuplicationDensity, scoreCoverage, scoreOpenDefects, scoreDefectsDensity, scoreAverageAge, scoreAverageTimeFix, scoreSuccessRate, scoreEffectiveness, testsCase, defectsDensity, totalTestExecutions, totalProblems, ncloc, issuesBlocker, issuesCriticals, issuesMajor, issuesBug, issuesVulnerability, issuesCodeSmell, successRate, executionsPassed, medal
    }
}
