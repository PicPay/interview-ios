//
//  TimeMetric.swift
//  InterviewUITests
//
//  Created by Lucas Ferreira Machado on 31/08/21.
//

import XCTest

public enum TimeUnit: Double {
    case nano = 0.000_000_001
    case milli = 0.001
    case seconds = 1

    static var defaultScale: Double {
        return TimeUnit.seconds.rawValue
    }
}

public struct TimeMetric {
    public let value: Double
    public let unit: TimeUnit

    public init(value: Double, unit: TimeUnit) {
        self.value = value
        self.unit = unit
    }

    public func to(unit: TimeUnit) -> TimeMetric {
        return TimeMetric(value: self.value * self.unit.rawValue * TimeUnit.seconds.rawValue / unit.rawValue, unit: unit)
    }
}

public extension Double {
    var nano: TimeMetric {
        return TimeMetric(value: self, unit: .nano)
    }

    var milli: TimeMetric {
        return TimeMetric(value: self, unit: .milli)
    }

    var second: TimeMetric {
        return TimeMetric(value: self, unit: .seconds)
    }
}

public func +(left: TimeMetric, right: TimeMetric) -> TimeMetric {
    return compute(left, right: right, operation: +)
}

public func -(left: TimeMetric, right: TimeMetric) -> TimeMetric {
    return compute(left, right: right, operation: -)
}

public func *(left: TimeMetric, right: TimeMetric) -> TimeMetric {
    return compute(left, right: right, operation: *)
}

public func /(left: TimeMetric, right: TimeMetric) -> TimeMetric {
    guard right.value != 0 else {
        fatalError("dividedByZero")
    }

    return compute(left, right: right, operation: /)
}

public func compute(_ left: TimeMetric, right: TimeMetric, operation: (Double, Double) -> Double) -> TimeMetric {
//    let (min, max) = left.unit.rawValue < right.unit.rawValue ? (left, right) : (right, left)
    let result = operation(left.value, right.to(unit: left.unit).value)
    return TimeMetric(value: result, unit: left.unit)
}


public func >(left: TimeMetric, right: TimeMetric) -> Bool {
    return compute(left, right: right, operation: -).value > 0.0
}

public func >=(left: TimeMetric, right: TimeMetric) -> Bool {
    return compute(left, right: right, operation: -).value >= 0.0
}

public func ==(left: TimeMetric, right: TimeMetric) -> Bool {
    return compute(left, right: right, operation: -).value == 0.0
}

public func <=(left: TimeMetric, right: TimeMetric) -> Bool {
    return compute(left, right: right, operation: -).value <= 0.0
}

public func <(left: TimeMetric, right: TimeMetric) -> Bool {
    return compute(left, right: right, operation: -).value < 0.0
}

extension TimeMetric {

    static func currentTimeInNanos() -> TimeMetric {
        let timeInNanos = Double(DispatchTime.now().uptimeNanoseconds)
        return TimeMetric(value: timeInNanos, unit: .nano)
    }

    func integerValue() -> UInt64 {
        UInt64(value)
    }
}
