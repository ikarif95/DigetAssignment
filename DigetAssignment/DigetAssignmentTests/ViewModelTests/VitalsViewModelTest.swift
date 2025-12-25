//
//  VitalsViewModelTest.swift
//  DigetAssignment
//
//  Created by Iftikhar Arif on 12/25/25.
//

import XCTest
import Combine
@testable import DigetAssignment

final class VitalsViewModelTests: XCTestCase {

    private var viewModel: VitalsViewModel!
    private var mockUseCase: MockGetVitalsUseCase!
    private var cancellables: Set<AnyCancellable>!

    private let patientId = UUID()

    override func setUp() {
        super.setUp()
        mockUseCase = MockGetVitalsUseCase()
        viewModel = VitalsViewModel(getVitalsUseCase: mockUseCase, patientId: patientId)
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        mockUseCase = nil
        cancellables = nil
        super.tearDown()
    }

    // MARK: - Tests

    func test_loadVitals_failure_emitsError() {
        // Given
        let error = NSError(domain: "TestError", code: 1)
        mockUseCase.result = .failure(error)

        let expectation = XCTestExpectation(description: "Error state")

        viewModel.$state
            .dropFirst(2) // idle → loading
            .sink { state in
                if case .error(let receivedError) = state {
                    XCTAssertNotNil(receivedError)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        // When
        viewModel.loadVitals()

        // Then
        wait(for: [expectation], timeout: 1)
    }
}
