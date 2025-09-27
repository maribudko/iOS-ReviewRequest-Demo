//
//  Assembler.swift
//  iOS-Test
//
//  Created by Mari Budko on 27.09.2025.
//

import Swinject

public final class AppAssembler {
    public static let shared = AppAssembler()
    
    private let assembler: Assembler
    public let resolver: DIResolver
    
    private init() {
        self.assembler = Assembler()
        self.resolver = SwinjectResolver(resolver: assembler.resolver)
    }
    
    public func addAssembly(assembly: Assembly) {
        assembler.apply(assembly: assembly)
    }
    
    public func addAssemblies(assemblies: [Assembly]) {
        assembler.apply(assemblies: assemblies)
    }
}
