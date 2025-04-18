
import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

@main
struct Plugin: CompilerPlugin {
  let providingMacros: [Macro.Type] = [
    DatabaseStateMacro.self,
    NormalizedStorageMacro.self,
    TableMacro.self,
    IndexMacro.self,
  ]
}
