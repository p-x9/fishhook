//
//  fishhook.swift
//
//
//  Created by p-x9 on 2023/11/27.
//
//

import Foundation
import MachO
@_implementationOnly import fishhookC


public class Rebinding {
    public let name: String
    public let replacement: UnsafeMutableRawPointer
    public let replaced: UnsafeMutablePointer<UnsafeMutableRawPointer?>?

    public init(
        name: String,
        replacement: UnsafeMutableRawPointer,
        replaced: UnsafeMutablePointer<UnsafeMutableRawPointer?>?
    ) {
        self.name = name
        self.replacement = replacement
        self.replaced = replaced
    }
}

@discardableResult
public func rebindSymbol(_ rebinding: Rebinding) -> Bool {
    rebindSymbol(
        name: rebinding.name,
        replacement: rebinding.replacement,
        replaced: rebinding.replaced
    )
}

@discardableResult
public func rebindSymbol(
    name: String,
    replacement: UnsafeMutableRawPointer,
    replaced: UnsafeMutablePointer<UnsafeMutableRawPointer?>?
) -> Bool {
    name.withCString {
        var rebindings = [
            fishhookC.rebinding(
                name: $0,
                replacement: replacement,
                replaced: replaced)
        ]
        return rebind_symbols(&rebindings, 1) != -1
    }
}

@discardableResult
public func rebindSymbolsImage(
    header: UnsafePointer<mach_header>,
    slide: intptr_t,
    rebinding: Rebinding
) -> Bool {
    rebindSymbolsImage(
        header: header,
        slide: slide,
        name: rebinding.name,
        replacement: rebinding.replacement,
        replaced: rebinding.replaced
    )
}

@discardableResult
public func rebindSymbolsImage(
    header: UnsafePointer<mach_header>,
    slide: intptr_t,
    name: String,
    replacement: UnsafeMutableRawPointer,
    replaced: UnsafeMutablePointer<UnsafeMutableRawPointer?>?
) -> Bool {
    name.withCString {
        var rebindings = [
            fishhookC.rebinding(
                name: $0,
                replacement: replacement,
                replaced: replaced)
        ]
        return rebind_symbols_image(
            UnsafeMutableRawPointer(mutating: header),
            slide,
            &rebindings,
            1
        ) != -1
    }
}
