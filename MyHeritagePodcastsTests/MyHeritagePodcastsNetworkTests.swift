//
//  MyHeritagePodcastsNetworkTests.swift
//  MyHeritagePodcastsTests
//
//  Created by Mihai-Ionut Ghete on 22.06.2022.
//

import XCTest
@testable import MyHeritagePodcasts

class MyHeritagePodcastsNetworkTests: XCTestCase {
    var sut: URLSession!
    var monitor: NetworkMonitorManager!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = URLSession(configuration: .default)
        monitor = NetworkMonitorManager()
    }
    
    override func tearDownWithError() throws {
        monitor = nil
        try super.tearDownWithError()
    }
    
    func testHTTPRequestValidStatusCode() throws {
        try XCTSkipUnless(
            monitor.status == .satisfied,
            "Exist test. No network connection.")
        
        let urlString = "https://itunes.apple.com/search?term=myheritage&entity=podcast&limit=1"
        let url = URL(string: urlString)!
        
        let promise = expectation(description: "Status code: 200")
        let dataTask = sut.dataTask(with: url) { _, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
    }
}
