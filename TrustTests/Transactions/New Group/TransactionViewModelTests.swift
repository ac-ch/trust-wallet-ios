// Copyright SIX DAY LLC. All rights reserved.

import XCTest
@testable import Trust

class TransactionViewModelTests: XCTestCase {

    func testErrorState() {
        let viewModel = TransactionViewModel(transaction: .make(state: .error), config: .make(), chainState: .make(), currentWallet: .make())

    }

    func testPendingState() {
        let blockNumber = 1
        let chainState: ChainState = .make()
        chainState.latestBlock = blockNumber

        let viewModel = TransactionViewModel(transaction: .make(blockNumber: blockNumber), config: .make(), chainState: chainState, currentWallet: .make())

        XCTAssertEqual(.none, viewModel.confirmations)
    }

    func testCompleteStateWhenLatestBlockBehind() {
        let blockNumber = 3
        let chainState: ChainState = .make()
        chainState.latestBlock = blockNumber - 1

        let viewModel = TransactionViewModel(transaction: .make(blockNumber: blockNumber), config: .make(), chainState: chainState, currentWallet: .make())

        XCTAssertNil(viewModel.confirmations)
    }

    func testCompleteState() {
        let blockNumber = 3
        let chainState: ChainState = .make()
        chainState.latestBlock = blockNumber

        let viewModel = TransactionViewModel(transaction: .make(blockNumber: 1), config: .make(), chainState: chainState, currentWallet: .make())

        XCTAssertEqual(2, viewModel.confirmations)
    }
}
