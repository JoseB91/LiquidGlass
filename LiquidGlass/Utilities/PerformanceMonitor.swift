//
//  PerformanceMonitor.swift
//  LiquidGlass
//
//  Created by José Briones on 18/1/26.
//

import Foundation
import QuartzCore

@Observable
final class PerformanceMonitor {
    var fps: Double = 0
    var isRunning: Bool = false

    private var displayLink: CADisplayLink?
    private var lastTimestamp: CFTimeInterval = 0
    private var frameCount: Int = 0

    func start() {
        guard !isRunning else { return }
        isRunning = true
        frameCount = 0
        lastTimestamp = 0

        displayLink = CADisplayLink(target: self, selector: #selector(update))
        displayLink?.add(to: .main, forMode: .common)
    }

    func stop() {
        displayLink?.invalidate()
        displayLink = nil
        isRunning = false
    }

    @objc private func update(link: CADisplayLink) {
        if lastTimestamp == 0 {
            lastTimestamp = link.timestamp
            return
        }

        frameCount += 1
        let elapsed = link.timestamp - lastTimestamp

        if elapsed >= 1.0 {
            fps = Double(frameCount) / elapsed
            frameCount = 0
            lastTimestamp = link.timestamp
        }
    }

    deinit {
        stop()
    }
}
