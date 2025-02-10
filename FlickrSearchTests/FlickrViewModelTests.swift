//
//  FlickrViewModelTests.swift
//  FlickrSearchTests
//
//  Created by Sha'Marcus Walker on 2/10/25.
//

import XCTest
@testable import FlickrSearch

final class FlickrViewModelTests: XCTestCase {
    var service: NetworkServices!
    var viewModel: FlickrViewModel!

    override func setUpWithError() throws {
        // Given

        service = FakeFlickrService()
        viewModel = FlickrViewModel(service: service)
    }

    override func tearDownWithError() throws {
        service = nil
        viewModel = nil
    }

    func testSearchImages_WhenExpectingCorrectResults() async throws {
        
        // When
        await viewModel.searchImages(for: "CorrectTestData")
        
        //Then
        XCTAssertNotNil(service)
        XCTAssertNotNil(viewModel)
        XCTAssertEqual(viewModel.images.count, 3)
        
        let imageData = viewModel.images.first!
        XCTAssertEqual(imageData.author, "nobody@flickr.com (\"wolf4max\")")
        XCTAssertEqual(imageData.thumbnailURL, URL(string:"https://live.staticflickr.com/65535/53846504523_8cdf3a5c8a_m.jpg")!)
        XCTAssertEqual(imageData.published, "2024-07-09T19:47:38Z")
        XCTAssertEqual(imageData.title, "Anxious little cat")
        XCTAssertNil(viewModel.error)


    }
    func testSearchImages_WhenExpectingNOResults_WhenSerachWordISEmpty() async throws {
        
        // When
        await viewModel.searchImages(for: "")
        
        //Then
        XCTAssertNotNil(service)
        XCTAssertNotNil(viewModel)
        XCTAssertEqual(viewModel.images.count, 0)
        XCTAssertNotNil(viewModel.error)
        XCTAssertEqual(viewModel.error,NetworkServiceError.invalidURL)

    }

    func testSearchImages_WhenExpectingNOResults_WhenExpectingDataParsingIsuse() async throws {
        
        // When
        await viewModel.searchImages(for: "FlickerTestWrongJsonData")
        
        //Then
        XCTAssertNotNil(service)
        XCTAssertNotNil(viewModel)
        XCTAssertEqual(viewModel.images.count, 0)
        XCTAssertNotNil(viewModel.error)
        XCTAssertEqual(viewModel.error,NetworkServiceError.decodingFailed)

    }
    
    func testSearchImages_WhenExpectingNOResults_WhenExpectingNoDataIsuse() async throws {
        
        // When
        await viewModel.searchImages(for: "FlickerTestNoData")
        
        //Then
        XCTAssertNotNil(service)
        XCTAssertNotNil(viewModel)
        XCTAssertEqual(viewModel.images.count, 0)
        XCTAssertNotNil(viewModel.error)
        XCTAssertEqual(viewModel.error,NetworkServiceError.decodingFailed)

    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
