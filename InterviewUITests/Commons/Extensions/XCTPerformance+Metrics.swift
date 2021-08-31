//
//  XCTPerformanceMeasurementTimestamp+Metrics.swift
//  InterviewUITests
//
//  Created by Lucas Ferreira Machado on 31/08/21.
//

import XCTest

extension XCTPerformanceMeasurementTimestamp {

    func toTimeMetricInNanos() -> TimeMetric {
        TimeMetric(value: Double(absoluteTimeNanoSeconds), unit: .nano)
    }
}
