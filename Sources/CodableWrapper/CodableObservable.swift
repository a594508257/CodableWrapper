//
//  CodableObservable.swift
//  KZCodable
//
//  Created by Monochrome on 2024/4/17.
//

public typealias CodableObservable = DecodableObservable & EncodableObservable

public protocol EncodableObservable {}

public protocol DecodableObservable {
    func decodeDidFinish()
}

public extension DecodableObservable {
    func decodeDidFinish() {}
}
