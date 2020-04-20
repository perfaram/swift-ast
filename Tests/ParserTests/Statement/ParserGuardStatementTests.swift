/*
   Copyright 2017 Ryuichi Intellectual Property and the Yanagiba project contributors

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/

import XCTest

@testable import AST
@testable import Parser

class ParserGuardStatementTests: XCTestCase {
  func testGuardStmt() {
    parseStatementAndTest("guard foo else {}", "guard foo else {}", testClosure: { stmt in
      guard let guardStmt = stmt as? GuardStatement else {
        XCTFail("Failed in parsing a while statement.")
        return
      }
      XCTAssertEqual(guardStmt.conditionList.count, 1)
      XCTAssertEqual(guardStmt.conditionList[0].textDescription, "foo")
      XCTAssertTrue(guardStmt.codeBlock.statements.isEmpty)
    })
  }

  func testSourceRange() {
    parseStatementAndTest("guard foo else {}", "guard foo else {}", testClosure: { stmt in
      XCTAssertEqual(stmt.sourceRange, getRange(1, 1, 1, 18))
    })
  }

    func testStrongSelfTest() {
        parseStatementAndTest("guard let self = self else {}", "guard let self = self else {}", testClosure: { stmt in
            guard stmt is GuardStatement else {
                XCTFail("Failed in parsing a while statement with self token.")
                return
            }
            XCTAssert(true)
        })
    }

  static var allTests = [
    ("testGuardStmt", testGuardStmt),
    ("testSourceRange", testSourceRange),
  ]
}
