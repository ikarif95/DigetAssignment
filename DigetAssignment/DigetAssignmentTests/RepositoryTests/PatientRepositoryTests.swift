//
//  PatientRepositoryTests.swift
//  DigetAssignment
//
//  Created by Iftikhar Arif on 12/24/25.
//
//
//import XCTest
//import Combine
//@testable import DigetAssignment
//
//final class PatientRepositoryTests: XCTestCase {
//    var sut: PatientRepository!
//    var mockDataSource: MockDataSource!
//    var cancellables: Set<AnyCancellable>!
//    
//    override func setUp() {
//        super.setUp()
//        mockDataSource = MockDataSource.shared
//        sut = PatientRepository(dataSource: mockDataSource)
//        cancellables = []
//    }
//    
//    override func tearDown() {
//        sut = nil
//        cancellables = nil
//        super.tearDown()
//    }
//    
//    func testGetPatient_ReturnsPatient() {
//        // Given
//        let expectation = XCTestExpectation(description: "Patient retrieved")
//        let expectedPatient = mockDataSource.mockPatient
//        
//        // When
//        sut.getPatient(id: expectedPatient.id)
//            .sink { completion in
//                if case .failure = completion {
//                    XCTFail("Should not fail")
//                }
//            } receiveValue: { patient in
//                XCTAssertEqual(patient, expectedPatient)
//                expectation.fulfill()
//            }
//            .store(in: &cancellables)
//        
//        // Then
//        wait(for: [expectation], timeout: 2.0)
//    }
//    
//    func testGetCurrentPatient_ReturnsCurrentPatient() {
//        // Given
//        let expectation = XCTestExpectation(description: "Current patient retrieved")
//        
//        // When
//        sut.getCurrentPatient()
//            .sink { completion in
//                if case .failure = completion {
//                    XCTFail("Should not fail")
//                }
//            } receiveValue: { patient in
//                XCTAssertNotNil(patient)
//                expectation.fulfill()
//            }
//            .store(in: &cancellables)
//        
//        // Then
//        wait(for: [expectation], timeout: 2.0)
//    }
//}
