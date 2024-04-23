//
//  CodingIgnore.swift
//  KZCodable
//
//  Created by Monochrome on 2024/4/2.
//

import SwiftSyntax
import SwiftSyntaxMacros

public struct CodingIgnoreMacro: PeerMacro {
    public static func expansion(of node: AttributeSyntax, 
                                 providingPeersOf declaration: some DeclSyntaxProtocol,
                                 in context: some MacroExpansionContext) throws -> [DeclSyntax] {
        return []
    }
}

public struct DecodingIgnoreMacro: PeerMacro {
    public static func expansion(of node: AttributeSyntax, 
                                 providingPeersOf declaration: some DeclSyntaxProtocol,
                                 in context: some MacroExpansionContext) throws -> [DeclSyntax] {
        return []
    }
}

public struct EncodingIgnoreMacro: PeerMacro {
    public static func expansion(of node: AttributeSyntax, 
                                 providingPeersOf declaration: some DeclSyntaxProtocol,
                                 in context: some MacroExpansionContext) throws -> [DeclSyntax] {
        return []
    }
}
