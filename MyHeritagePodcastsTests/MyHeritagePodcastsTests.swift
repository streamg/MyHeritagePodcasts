//
//  MyHeritagePodcastsTests.swift
//  MyHeritagePodcastsTests
//
//  Created by Mihai-Ionut Ghete on 22.06.2022.
//

import XCTest
@testable import MyHeritagePodcasts
import Network

class MyHeritagePodcastsTests: XCTestCase {
    var sut: DataManager!
    var monitor: NWPathMonitor!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = DataManager()
        monitor = NWPathMonitor()
    }

    override func tearDownWithError() throws {
        sut = nil
        monitor = nil
        try super.tearDownWithError()
    }
    
    func testReturnPodcastsCount() {
        let promise = expectation(description: "Completion handler invoked")
        sut.fetchPodcasts(from: "myheritage", limit: 25) { podcasts in
            XCTAssertLessThan(1, podcasts!.count, "'myheritage' search returned 0 results")
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 5)
    }
}
