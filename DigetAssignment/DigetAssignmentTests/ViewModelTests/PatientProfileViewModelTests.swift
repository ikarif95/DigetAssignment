//
//  PatientProfileViewModelTests.swift
//  DigetAssignment
//
//  Created by Iftikhar Arif on 12/24/25.
//

import XCTest
import Combine
@testable import DigetAssignment

final class PatientProfileViewModelTests: XCTestCase {
    var sut: PatientProfileViewModel!
    var mockUseCase: MockGetPatientProfileUseCase!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockUseCase = MockGetPatientProfileUseCase()
        sut = PatientProfileViewModel(getPatientUseCase: mockUseCase, coordinator: nil)
        cancellables = []
    }
    
    override func tearDown() {
        sut = nil
        mockUseCase = nil
        cancellables = nil
        super.tearDown()
    }
    
    // MARK: - Initial State Tests
    
    func testStateIdle() {
        if case .idle = sut.state {
            // Success
        } else {
            XCTFail("Initial state should be idle")
        }
    }
    
    // MARK: - Load Patient Success Tests
    
    func testPatientLoadSuccess() {
        // Given
        let expectedPatient = TestDataFactory.createMockPatient()
        mockUseCase.executeResult = .success(expectedPatient)
        
        let expectation = expectation(description: "State updates to loaded")
        var stateUpdates: [PatientProfileViewModel.State] = []
        
        sut.$state
            .sink { state in
                stateUpdates.append(state)
                if case .loaded = state {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        sut.loadPatient()
        
        // Then
        waitForExpectations(timeout: 1.0) { _ in
            XCTAssertTrue(self.mockUseCase.executeCalled)
            XCTAssertEqual(self.mockUseCase.executeCallCount, 1)
            
            // Verify state progression: idle -> loading -> loaded
            XCTAssertEqual(stateUpdates.count, 3)
            
            if case .idle = stateUpdates[0] {
                // Success
            } else {
                XCTFail("First state should be idle")
            }
            
            if case .loading = stateUpdates[1] {
                // Success
            } else {
                XCTFail("Second state should be loading")
            }
            
            if case .loaded(let patient) = stateUpdates[2] {
                XCTAssertEqual(patient.id, expectedPatient.id)
                XCTAssertEqual(patient.fullName, expectedPatient.fullName)
            } else {
                XCTFail("Third state should be loaded")
            }
        }
    }
   
}
