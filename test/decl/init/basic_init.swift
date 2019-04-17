// RUN: %target-typecheck-verify-swift

class Foo {
  func bar(_: bar) {} // expected-error{{use of undeclared type 'bar'}}
}

class C {
	var triangle : triangle  // expected-error{{use of undeclared type 'triangle'}}

	init() {}
}

typealias t = t // expected-error {{type alias 't' references itself}}
// expected-note@-1{{type declared here}}

extension Foo {
  convenience init() {} // expected-error{{invalid redeclaration of synthesized 'init()'}}
}

class InitClass {
  init(arg: Bool) {} // expected-note{{add '@objc' to make this declaration overridable}}
}
class InitSubclass: InitClass {}
extension InitSubclass {
  convenience init(arg: Bool) {}
  // expected-error@-1{{invalid redeclaration of inherited 'init(arg:)'}}
  // expected-error@-2{{overriding non-@objc declarations from extensions is not supported}}
}

struct InitStruct {
  let foo: Int
}
extension InitStruct {
  init(foo: Int) {} // expected-error{{invalid redeclaration of synthesized memberwise 'init(foo:)'}}
}

// <rdar://problem/17564699> QoI: Structs should get convenience initializers
struct MyStruct {
  init(k: Int) {
  }
  convenience init() {  // expected-error {{delegating initializers in structs are not marked with 'convenience'}} {{3-15=}}
    self.init(k: 1)
  }
}
