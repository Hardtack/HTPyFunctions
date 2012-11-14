//
//  HTPyBuiltins.h
//  HTPyBuiltins
//
//  Created by 최건우 on 12. 11. 14..
//  Copyright (c) 2012년 최건우. All rights reserved.
//

#import <Foundation/Foundation.h>

#define HTIterable id<NSFastEnumeration, NSObject>

/**
 * function like all in python
 */
BOOL HTAll(HTIterable iterable);
/**
 * function like any in python
 */
BOOL HTAny(HTIterable iterable);
/**
 * function like bool in python
 */
BOOL HTBool(id obj);
/**
 * function like dict in python
 */
NSDictionary* HTDict(HTIterable iterable);
/**
 * function like enumerate in python
 * Returns YES if it enumerated all element in `iterable`
 * You can stop Iteration by returning `NO` in `block`
 */
void HTEnumerate(HTIterable iterable, NSInteger start, BOOL(^block)(NSInteger n, id obj));

/**
 * function like filter in python
 */
NSArray* HTFilter(BOOL(^block)(id obj), HTIterable iterable);
/**
 * function like isisntance in python
 */
BOOL HTIsinstance(id obj, HTIterable classes);
/**
 * function like issubclass in python
 */
BOOL HTIssubclass(Class cls, HTIterable classes);
/**
 * function like list in python
 */
NSArray* HTArray(HTIterable iterable);
/**
 * function like map in python
 */
NSArray* HTMap(id(^block)(id obj), HTIterable iterable);
/**
 * function like max in python
 */
id HTMax(NSComparisonResult(^block)(id first, id second), id first, ...) NS_REQUIRES_NIL_TERMINATION;
/**
 * function like min in python
 */
id HTMin(NSComparisonResult(^block)(id first, id second), id first, ...) NS_REQUIRES_NIL_TERMINATION;
/**
 * function like range in python
 */
NSArray* HTRange(NSInteger stop);
/**
 * function like range in python
 */
NSArray* HTRangeStart(NSInteger start, NSInteger stop);
/**
 * function like range in python
 */
NSArray* HTRangeStep(NSInteger start, NSInteger stop, NSInteger step);
/**
 * function like reversed in python
 */
HTIterable HTReversed(HTIterable iterable);
/**
 * function like sum in python
 */
id HTSum(HTIterable iterable);
/**
 * function like xmap in python
 * Returns YES if it iterated all element in `iterable`
 * You can stop Iteration by returning `NO` in `block`
 */
BOOL HTXMap(id(^mapBlock)(id obj), HTIterable iterable, BOOL(^block)(id obj));
/**
 * function like chain in python
 */
HTIterable HTChain(HTIterable iterables);