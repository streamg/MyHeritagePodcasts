//
//  Observable.swift
//  MyHeritagePodcasts
//
//  Created by Mihai-Ionut Ghete on 22.06.2022.
//

import Foundation

public final class Observable<T> {
  //1
  public typealias Listener = (T) -> Void
  public var listener: Listener?
  //2
  public var value: T {
    didSet {
      listener?(value)
    }
  }
  //3
  public init(_ value: T) {
    self.value = value
  }
  //4
  public func bind(listener: Listener?) {
    self.listener = listener
    listener?(value)
  }
}
