//
//  TimePerformanceMetric.swift
//  InterviewUITests
//
//  Created by Lucas Ferreira Machado on 31/08/21.
//  Copyright © 2021 PicPay. All rights reserved.
//

import XCTest

final class TimePerformanceMetric: NSObject, XCTMetric {
    var startTimes: [TimeMetric] = []
    var endTimes: [TimeMetric] = []
    var measurements: [TimeMetric] = Array()

    func average(unit: TimeUnit) -> TimeMetric {
        var total = TimeMetric(value: 0.0, unit: unit)
        let count = measurements.count-1
        for index in 1...count {
            total = total + measurements[index]
        }
        return TimeMetric(value: total.value / Double(count), unit: unit)
    }

    // This will get called on main queue/thread.
    func reportMeasurements(from startTime: XCTPerformanceMeasurementTimestamp, to endTime: XCTPerformanceMeasurementTimestamp) throws -> [XCTPerformanceMeasurement] {

        let startTimeNano = startTime.toTimeMetricInNanos()
        let endTimeNano = endTime.toTimeMetricInNanos()

        // NOTE: We can change the order of if and else-if to run our monotonic-time implementation.
        var timeDiffNano: TimeMetric = TimeMetric(value: 0.0, unit: .nano)
        if endTimeNano > startTimeNano {
            timeDiffNano = endTimeNano - startTimeNano
        } else if let startTimeNS = startTimes.first, let endTimeNS = endTimes.first, endTimeNS > startTimeNS {
            timeDiffNano = endTimeNS - startTimeNS
        }
        startTimes.removeFirst()
        endTimes.removeFirst()
        measurements.append(timeDiffNano)

        let measurement = Measurement(value: timeDiffNano.value, unit: Unit(symbol: UnitDuration.nanoseconds.symbol))
        return [XCTPerformanceMeasurement(identifier: "com.sk.XCTPerformanceMetric_MonotonicClockTime", displayName: "Time Performance", value: measurement)]
    }

    // This will get called on background queue i.e. any random thread for each iteration.
    func willBeginMeasuring() {
        startTimes.append(TimeMetric.currentTimeInNanos())
    }

    // This will get called on background queue i.e. any random thread for each iteration.
    func didStopMeasuring() {
        endTimes.append(TimeMetric.currentTimeInNanos())
    }

    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
