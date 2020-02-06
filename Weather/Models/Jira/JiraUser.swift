//
//  JiraUser.swift
//  Weather
//
//  Created by Gabriel Aguido Fraga on 25/09/19.
//  Copyright © 2019 Aguido. All rights reserved.
//

import Foundation

struct JiraUser: Identifiable, Codable {
        
    let jiraUserSelf: String
    let key, id, accountType, name: String
    let emailAddress: String
    let avatarUrls: AvatarUrls
    let displayName: String
    let active: Bool
    let timeZone, locale: String
    let groups, applicationRoles: ApplicationRoles
    let expand: String

    enum CodingKeys: String, CodingKey {
        case jiraUserSelf = "self"
        case key
        case id = "accountId"
        case accountType, name, emailAddress, avatarUrls, displayName, active, timeZone, locale, groups, applicationRoles, expand
    }
}
