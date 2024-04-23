//
//  CodableSubclass.swift
//  KZCodable
//
//  Created by Monochrome on 2024/3/29.
//

import SwiftSyntax
import SwiftSyntaxMacros

public struct EncodableSubclassMacro: MemberMacro {
    public static func expansion(of node: SwiftSyntax.AttributeSyntax,
                                 providingMembersOf declaration: some SwiftSyntax.DeclGroupSyntax,
                                 in context: some SwiftSyntaxMacros.MacroExpansionContext) throws -> [SwiftSyntax.DeclSyntax]
    {
        guard declaration.is(ClassDeclSyntax.self) else {
            throw ASTError("not a `subclass`")
        }

        let propertyContainer = try ModelMemberPropertyContainer(decl: declaration, context: context)
        let encoder = try propertyContainer.genEncodeFunction(config: .init(isOverride: true))
        return [encoder]
    }
}
