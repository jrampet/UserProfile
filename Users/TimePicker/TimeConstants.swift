//
//  TimeConstants.swift
//  Users
//
//  Created by Jeyaram on 11/07/21.
//

import Foundation
public enum TimeMeridian {
    case am,pm
}

extension TimeMeridian: CustomStringConvertible {
    public var description: String {
        switch self {
        case .am: return "AM"
        case .pm: return "PM"
        }
    }
}
public struct TimePickerModel {
    public var hour: Int = 0
    public var minute: Int = 0
    public var is24: Bool = false
    public var meridian: TimeMeridian = .am
}
