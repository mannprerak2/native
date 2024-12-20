// Copyright (c) 2024, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

#import <Foundation/NSThread.h>

#include "arc_test.h"

#if !__has_feature(objc_arc)
#error "This file must be compiled with ARC enabled"
#endif

@implementation ArcTestObject

+ (instancetype)allocTheThing {
  return [ArcTestObject alloc];
}

+ (instancetype)newWithCounter:(int32_t*) _counter {
  return [[ArcTestObject alloc] initWithCounter: _counter];
}

- (instancetype)initWithCounter:(int32_t*) _counter {
  counter = _counter;
  ++*counter;
  return [super init];
}

+ (instancetype)makeAndAutorelease:(int32_t*) _counter {
  return [[ArcTestObject alloc] initWithCounter: _counter];
}

- (void)setCounter:(int32_t*) _counter {
  counter = _counter;
  ++*counter;
}

- (void)dealloc {
  --*counter;
}

- (ArcTestObject*)copyMe {
  return [[ArcTestObject alloc] initWithCounter: counter];
}

- (ArcTestObject*)mutableCopyMe {
  return [[ArcTestObject alloc] initWithCounter: counter];
}

- (id)copyWithZone:(NSZone*) zone {
  return [[ArcTestObject alloc] initWithCounter: counter];
}

- (ArcTestObject*)returnsRetained NS_RETURNS_RETAINED {
  return [self copyMe];
}

- (ArcTestObject*)copyMeNoRetain __attribute__((ns_returns_not_retained)) {
  return [self copyMe];
}

- (ArcTestObject*)copyMeAutorelease __attribute__((ns_returns_autoreleased)) {
  return [self copyMe];
}

- (ArcTestObject*)copyMeConsumeSelf __attribute__((ns_consumes_self)) {
  return [self copyMe];
}

+ (void)consumeArg:(ArcTestObject*) __attribute((ns_consumed)) arg {}

@end

@implementation ArcDtorTestObject

- (instancetype)initWithCounters:(int32_t*) _dtorCounter
    onMainThread: (int32_t*) _dtorOnMainThreadCounter {
  dtorCounter = _dtorCounter;
  dtorOnMainThreadCounter = _dtorOnMainThreadCounter;
  return [super init];
}

- (void)dealloc {
  ++*dtorCounter;
  if ([NSThread isMainThread]) {
    ++*dtorOnMainThreadCounter;
  }
}
@end
