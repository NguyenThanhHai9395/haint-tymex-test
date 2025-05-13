//
//  UserDetailViewModelTests.swift
//  tymex-test
//
//  Created by Hai Nguyen on 13/5/25.
//

import XCTest
@testable import tymex_test

final class UserDetailViewModelTests: XCTestCase {

    func testLoad_Successful() async {
        let mockService = MockGithubService()
        let viewModel = UserDetailViewModel(userName: "mockuser", service: mockService)

        await viewModel.load()

        XCTAssertNotNil(viewModel.userDetail)
        XCTAssertEqual(viewModel.userDetail?.login, "mockuser")
        XCTAssertNil(viewModel.errorMessage)
    }

    func testLoad_Failure() async {
        let mockService = MockGithubService()
        mockService.shouldFail = true
        let viewModel = UserDetailViewModel(userName: "mockuser", service: mockService)

        await viewModel.load()

        XCTAssertNil(viewModel.userDetail)
        XCTAssertEqual(viewModel.errorMessage, "Failed to load user detail.")
    }

    func testIsLoading_State() async {
        let mockService = MockGithubService()
        let viewModel = UserDetailViewModel(userName: "mockuser", service: mockService)

        let expectation = XCTestExpectation(description: "Wait for loading state")

        Task {
            let loadingStart = viewModel.isLoading
            XCTAssertFalse(loadingStart)

            await viewModel.load()

            let loadingEnd = viewModel.isLoading
            XCTAssertFalse(loadingEnd)

            expectation.fulfill()
        }

        await fulfillment(of: [expectation], timeout: 3.0)
    }
}
