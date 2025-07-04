//
//  MoveReducer.swift
//  DeepDiff
//
//  Created by Khoa Pham.
//  Copyright © 2018 Khoa Pham. All rights reserved.
//

import Foundation

struct MoveReducer<T> {
  func reduce<Value: DeepEquatable>(changes: [Change<Value>]) -> [Change<Value>] {
    // Find pairs of .insert and .delete with same item
    let inserts = changes.compactMap({ $0.insert })

    if inserts.isEmpty {
      return changes
    }

    var changes = changes
    inserts.forEach { insert in
      if let insertIndex = changes.firstIndex(where: { insert.item.equal(object: $0.insert?.item) }),
        let deleteIndex = changes.firstIndex(where: { insert.item.equal(object: $0.delete?.item) }) {

        let insertChange = changes[insertIndex].insert!
        let deleteChange = changes[deleteIndex].delete!

        let move = Move<Value>(item: insert.item, fromIndex: deleteChange.index, toIndex: insertChange.index)

        // .insert can be before or after .delete
        let minIndex = min(insertIndex, deleteIndex)
        let maxIndex = max(insertIndex, deleteIndex)

        // remove both .insert and .delete, and replace by .move
        changes.remove(at: minIndex)
        changes.remove(at: maxIndex.advanced(by: -1))
        changes.insert(.move(move), at: minIndex)
      }
    }

    return changes
  }
}
