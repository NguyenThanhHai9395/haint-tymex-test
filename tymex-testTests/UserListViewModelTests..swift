//
//  UserListViewModelTests..swift
//  tymex-test
//
//  Created by Hai Nguyen on 13/5/25.
//

import XCTest
@testable import tymex_test

final class UserListViewModelTests: XCTestCase {

    // MARK: - Tests

    func testLoadInitial_Success() async {
        let mockService = MockGithubService()
        let viewModel = UserListViewModel(service: mockService)

        await viewModel.loadInitial()

        XCTAssertEqual(viewModel.users.count, 2)
        XCTAssertEqual(viewModel.users[0].login, "user1")
        XCTAssertEqual(viewModel.users[1].login, "user2")
    }

    func testLoadMore_AppendsUsersCorrectly() async {
        let mockService = MockGithubService()
        let viewModel = UserListViewModel(service: mockService)

        await viewModel.loadInitial()
        await viewModel.loadMore()

        XCTAssertEqual(viewModel.users.count, 4)
        XCTAssertEqual(viewModel.users.last?.login, "user2")
    }

    func testLoadMore_Failure_DoesNotCrash() async {
        let mockService = MockGithubService()
        mockService.shouldFail = true
        let viewModel = UserListViewModel(service: mockService)

        await viewModel.loadMore()

        XCTAssertTrue(viewModel.users.isEmpty)
    }
}
