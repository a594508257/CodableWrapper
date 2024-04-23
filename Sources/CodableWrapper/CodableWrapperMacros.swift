@attached(member, names: named(init(from:)), named(encode(to:)), arbitrary)
@attached(extension, conformances: Codable, CodableObservable)
public macro Codable() = #externalMacro(module: "CodableWrapperMacros", type: "Codable")

@attached(member, names: named(init(from:)), named(encode(to:)), arbitrary)
public macro CodableSubclass() = #externalMacro(module: "CodableWrapperMacros", type: "CodableSubclass")

@attached(member, names: named(init(from:)), arbitrary)
@attached(extension, conformances: Decodable, DecodableObservable)
public macro Decodable() = #externalMacro(module: "CodableWrapperMacros", type: "DecodableMacro")

@attached(member, names: named(init(from:)), arbitrary)
public macro DecodableSubclass() = #externalMacro(module: "CodableWrapperMacros", type: "DecodableSubclassMacro")

@attached(member, names: named(encode(to:)), arbitrary)
@attached(extension, conformances: Encodable, EncodableObservable)
public macro Encodable() = #externalMacro(module: "CodableWrapperMacros", type: "EncodableMacro")

@attached(member, names: named(encode(to:)), arbitrary)
public macro EncodableSubclass() = #externalMacro(module: "CodableWrapperMacros", type: "EncodableSubclassMacro")

@attached(peer)
public macro CodingKey(_ key: String ...) = #externalMacro(module: "CodableWrapperMacros", type: "CodingKey")

@attached(peer)
public macro CodingNestedKey(_ key: String ...) = #externalMacro(module: "CodableWrapperMacros", type: "CodingNestedKey")

@attached(peer)
public macro CodingIgnoreKey() = #externalMacro(module: "CodableWrapperMacros", type: "CodingIgnoreMacro")

@attached(peer)
public macro EncodingIgnoreKey() = #externalMacro(module: "CodableWrapperMacros", type: "EncodingIgnoreMacro")

@attached(peer)
public macro DecodingIgnoreKey() = #externalMacro(module: "CodableWrapperMacros", type: "DecodingIgnoreMacro")

@attached(peer)
public macro CodingTransformer(_ transformer: any TransformType) = #externalMacro(module: "CodableWrapperMacros", type: "CodingTransformer")
