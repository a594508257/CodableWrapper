//
//  CodableObservableTest.swift
//  KZCodableTests
//
//  Created by Monochrome on 2024/4/17.
//

import CodableWrapper
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

@Codable
class CodableObservable0Model {
    var defaultVal: String = "hello world"
    var strict: String = ""
    var noStrict: String?
    var autoConvert: Int?

    @CodingIgnoreKey
    var isSelected: Bool = true

    func decodeDidFinish() {
        print("调用父类 decodeDidFinish")
    }
}

@CodableSubclass
class CodableObservable1Model: CodableObservable0Model {
    var defaultVal2: String = Bool.random() ? "hello world" : ""

    @CodingKey("hello")
    var hi: String = "there"

    @CodingNestedKey("nested.hi")
    @CodingTransformer(StringPrefixTransform("HELLO -> "))
    var codingSupport: String

    @CodingNestedKey("nested.b")
    var nestedB: String

    var testGetter: String {
        nestedB
    }

    @CodingIgnoreKey
    lazy var isNestedB: Bool = {
        nestedB == "b value"
    }()

    @DecodingIgnoreKey
    var test: String?

    override func decodeDidFinish() {
        print("调用子类 decodeDidFinish")
    }
}

@Decodable
class DecodableObservable0Model {
    var name: String?

    func decodeDidFinish() {
        print("Decodable 调用父类 decodeDidFinish")
    }
}

@DecodableSubclass
class DecodableObservable1Model: DecodableObservable0Model {
    var age: Int = 0

    override func decodeDidFinish() {
        print("Decodable 调用子类 decodeDidFinish")
    }
}

@Encodable
class EncodableObservable0Model {
    var name: String?

    func decodeDidFinish() {
        print("Encodable 调用父类 decodeDidFinish")
    }
}

@EncodableSubclass
class EncodableObservable1Model: EncodableObservable0Model {
    var age: Int = 0

    override func decodeDidFinish() {
        print("Encodable 调用子类 decodeDidFinish")
    }
}

@Codable
struct StructModel {
    var name: String?
    var age: Int = 0

    mutating func decodeDidFinish() {
        print("修改前 age: \(age)")
        age = 1
        print("修改后 age: \(age)")
    }
}

final class CodableObservableTest: XCTestCase {
    func testCodableObservableUsage() throws {
        print("\nCodable")
        let jsonStr = """
        {
            "strict": "value of strict",
            "autoConvert": "998",
            "nested": {
                "hi": "nested there",
                "b": "b value"
            },
            "test": "aaa"
        }
        """

        print("解析父类")
        let model0 = try JSONDecoder().decode(CodableObservable0Model.self, from: jsonStr.data(using: .utf8)!)
        XCTAssertEqual(model0.defaultVal, "hello world")

        print("解析子类")
        let model1 = try JSONDecoder().decode(CodableObservable1Model.self, from: jsonStr.data(using: .utf8)!)
        XCTAssertEqual(model1.defaultVal, "hello world")
    }

    func testDecodableObservableUsage() throws {
        print("\nDecoable")
        let json2Str = """
        {
            "name": "111",
            "age": 22
        }
        """

        print("解析父类")
        let model2 = try JSONDecoder().decode(DecodableObservable0Model.self, from: json2Str.data(using: .utf8)!)
        XCTAssertEqual(model2.name, "111")

        print("解析子类")
        let model3 = try JSONDecoder().decode(DecodableObservable1Model.self, from: json2Str.data(using: .utf8)!)
        XCTAssertEqual(model3.age, 22)
    }

    func testEncodableObservableUsage() throws {
        print("解析父类")
        let model4 = EncodableObservable0Model()
        model4.name = "111"
        let encoded4 = try JSONEncoder().encode(model4)
        let dict4 = try JSONSerialization.jsonObject(with: encoded4) as! [String: Any]
        XCTAssertEqual(model4.name, dict4["name"] as? String)
        print(String(data: encoded4, encoding: .utf8)!)

        print("解析子类")
        let model5 = EncodableObservable1Model()
        model5.name = "111"
        model5.age = 22
        let encoded5 = try JSONEncoder().encode(model5)
        let dict5 = try JSONSerialization.jsonObject(with: encoded5) as! [String: Any]
        XCTAssertEqual(model5.name, dict5["name"] as? String)
        XCTAssertEqual(model5.age, dict5["age"] as! Int)
        print(String(data: encoded5, encoding: .utf8)!)
    }

    func testStructObservableUsage() throws {
        let json = #"{"age": 2, "name": "233"}"#
        let model = try JSONDecoder().decode(StructModel.self, from: json.data(using: .utf8)!)
        XCTAssertEqual(model.age, 1)
    }
}
