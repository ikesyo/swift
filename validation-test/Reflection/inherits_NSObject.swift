// RUN: rm -rf %t && mkdir -p %t
// RUN: %target-build-swift -lswiftSwiftReflectionTest %s -o %t/inherits_NSObject
// RUN: %target-run %target-swift-reflection-test %t/inherits_NSObject | %FileCheck %s --check-prefix=CHECK --check-prefix=CHECK-%target-ptrsize

// REQUIRES: objc_interop
// REQUIRES: executable_test

import Foundation

import SwiftReflectionTest

class BaseNSClass : NSObject {
  var w: Int = 0
  var x: Bool = false
}

class DerivedNSClass : BaseNSClass {
  var y: Bool = false
  var z: Int = 0
}

let baseClass = BaseNSClass()
reflect(object: baseClass)

// CHECK-64: Reflecting an object.
// CHECK-64: Type reference:
// CHECK-64: (class inherits_NSObject.BaseNSClass)

// CHECK-64: Type info:
// CHECK-64-NEXT: (class_instance size=25 alignment=8 stride=32 num_extra_inhabitants=0
// CHECK-64-NEXT:   (field name=w offset=16
// CHECK-64-NEXT:     (struct size=8 alignment=8 stride=8 num_extra_inhabitants=0
// CHECK-64-NEXT:       (field name=_value offset=0
// CHECK-64-NEXT:         (builtin size=8 alignment=8 stride=8 num_extra_inhabitants=0))))
// CHECK-64-NEXT:   (field name=x offset=24
// CHECK-64-NEXT:     (struct size=1 alignment=1 stride=1 num_extra_inhabitants=254
// CHECK-64-NEXT:       (field name=_value offset=0
// CHECK-64-NEXT:         (builtin size=1 alignment=1 stride=1 num_extra_inhabitants=254)))))

// CHECK-32: Reflecting an object.
// CHECK-32: Type reference:
// CHECK-32: (class inherits_NSObject.BaseNSClass)

// CHECK-32: Type info:
// CHECK-32-NEXT: (class_instance size=21 alignment=4 stride=24 num_extra_inhabitants=0
// CHECK-32-NEXT:   (field name=w offset=16
// CHECK-32-NEXT:     (struct size=4 alignment=4 stride=4 num_extra_inhabitants=0
// CHECK-32-NEXT:       (field name=_value offset=0
// CHECK-32-NEXT:         (builtin size=4 alignment=4 stride=4 num_extra_inhabitants=0))))
// CHECK-32-NEXT:   (field name=x offset=20
// CHECK-32-NEXT:     (struct size=1 alignment=1 stride=1 num_extra_inhabitants=254
// CHECK-32-NEXT:       (field name=_value offset=0
// CHECK-32-NEXT:         (builtin size=1 alignment=1 stride=1 num_extra_inhabitants=254)))))

let derivedClass = DerivedNSClass()
reflect(object: derivedClass)

// CHECK-64: Reflecting an object.
// CHECK-64: Type reference:
// CHECK-64: (class inherits_NSObject.DerivedNSClass)

// CHECK-64: Type info:
// CHECK-64-NEXT: (class_instance size=40 alignment=8 stride=40 num_extra_inhabitants=0
// CHECK-64-NEXT:   (field name=y offset=25
// CHECK-64-NEXT:     (struct size=1 alignment=1 stride=1 num_extra_inhabitants=254
// CHECK-64-NEXT:       (field name=_value offset=0
// CHECK-64-NEXT:         (builtin size=1 alignment=1 stride=1 num_extra_inhabitants=254))))
// CHECK-64-NEXT:   (field name=z offset=32
// CHECK-64-NEXT:     (struct size=8 alignment=8 stride=8 num_extra_inhabitants=0
// CHECK-64-NEXT:       (field name=_value offset=0
// CHECK-64-NEXT:         (builtin size=8 alignment=8 stride=8 num_extra_inhabitants=0)))))

// CHECK-32: Reflecting an object.
// CHECK-32: Type reference:
// CHECK-32: (class inherits_NSObject.DerivedNSClass)

// CHECK-32: Type info:
// CHECK-32-NEXT: (class_instance size=24 alignment=4 stride=24 num_extra_inhabitants=0
// CHECK-32-NEXT:   (field name=y offset=17
// CHECK-32-NEXT:     (struct size=1 alignment=1 stride=1 num_extra_inhabitants=254
// CHECK-32-NEXT:       (field name=_value offset=0
// CHECK-32-NEXT:         (builtin size=1 alignment=1 stride=1 num_extra_inhabitants=254))))
// CHECK-32-NEXT:   (field name=z offset=20
// CHECK-32-NEXT:     (struct size=4 alignment=4 stride=4 num_extra_inhabitants=0
// CHECK-32-NEXT:       (field name=_value offset=0
// CHECK-32-NEXT:         (builtin size=4 alignment=4 stride=4 num_extra_inhabitants=0)))))

doneReflecting()