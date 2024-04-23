import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct CodableWrapperPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        Codable.self,
        CodableSubclass.self,
        DecodableMacro.self,
        DecodableSubclassMacro.self,
        EncodableMacro.self,
        EncodableSubclassMacro.self,
        CodingKey.self,
        CodingNestedKey.self,
        CodingTransformer.self,
        CodingIgnoreMacro.self,
        EncodingIgnoreMacro.self,
        DecodingIgnoreMacro.self
    ]
}
