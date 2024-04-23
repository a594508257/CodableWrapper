//
//  Decodable.swift
//  KZCodable
//
//  Created by Monochrome on 2024/3/29.
//

import SwiftSyntax
import SwiftSyntaxMacros

public struct DecodableMacro: ExtensionMacro, MemberMacro {
    public static func expansion(of node: AttributeSyntax,
                                 attachedTo declaration: some DeclGroupSyntax,
                                 providingExtensionsOf type: some TypeSyntaxProtocol,
                                 conformingTo protocols: [TypeSyntax],
                                 in context: some MacroExpansionContext) throws -> [ExtensionDeclSyntax] {
        var inheritedTypes: InheritedTypeListSyntax?
        if let declaration = declaration.as(StructDeclSyntax.self) {
            inheritedTypes = declaration.inheritanceClause?.inheritedTypes
        } else if let declaration = declaration.as(ClassDeclSyntax.self) {
            inheritedTypes = declaration.inheritanceClause?.inheritedTypes
        } else {
            throw ASTError("use @Decodable in `struct` or `class`")
        }

        let codableKey = "Decodable"
        let codableObservableKey = "DecodableObservable"
        var extesions = [codableKey, codableObservableKey]
        if let inheritedTypes = inheritedTypes {
            if inheritedTypes.contains(where: { $0.type.trimmedDescription == codableKey }) {
                extesions.removeAll { $0 == codableKey }
            }

            if inheritedTypes.contains(where: { $0.type.trimmedDescription == codableObservableKey }) {
                extesions.removeAll { $0 == codableObservableKey }
            }

            if extesions.count == 0 {
                return []
            }
        }

        let extensionsString = extesions.joined(separator: ", ")

        let ext: DeclSyntax =
            """
            extension \(type.trimmed): \(raw: extensionsString) {}
            """

        return [ext.cast(ExtensionDeclSyntax.self)]
    }

    public static func expansion(of node: SwiftSyntax.AttributeSyntax,
                                 providingMembersOf declaration: some SwiftSyntax.DeclGroupSyntax,
                                 in context: some SwiftSyntaxMacros.MacroExpansionContext) throws -> [SwiftSyntax.DeclSyntax]
    {
        // TODO: diagnostic do not implement `init(from:)` or `encode(to:))`

        let propertyContainer = try ModelMemberPropertyContainer(decl: declaration, context: context)
        let decoder = try propertyContainer.genDecoderInitializer(config: .init(isOverride: false))
        let memberwiseInit = try propertyContainer.genMemberwiseInit(config: .init(isOverride: false))
        return [decoder, memberwiseInit]
    }
}
