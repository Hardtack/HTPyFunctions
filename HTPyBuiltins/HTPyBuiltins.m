//
//  HTPyBuiltins.m
//  HTPyBuiltins
//
//  Created by 최건우 on 12. 11. 14..
//  Copyright (c) 2012년 최건우. All rights reserved.
//

#import "HTPyBuiltins.h"
/* Python-like functions */
BOOL HTAll(HTIterable iterable){
    for (id element in iterable) {
        if (!HTBool(element)) {
            return NO;
        }
    }
    return YES;
}

BOOL HTAny(HTIterable iterable){
    for (id element in iterable) {
        if (HTBool(element)) {
            return YES;
        }
    }
    return NO;
}
BOOL HTBool(id obj){
    if ([obj isKindOfClass:[NSNumber class]]) {
        return [obj boolValue];
    } else if (obj == nil || [obj isKindOfClass:[NSNull class]]){
        return NO;
    }
    return YES;
}

NSDictionary* HTDict(HTIterable iterable){
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    for (NSArray* element in iterable) {
        id key = [element objectAtIndex:0];
        id obj = [element objectAtIndex:1];
        [dict setObject:obj forKey:key];
    }
    return [NSDictionary dictionaryWithDictionary:dict];
}

void HTEnumerate(HTIterable iterable, NSInteger start, BOOL(^block)(NSInteger n, id obj)){
    for (id obj in iterable) {
        if (!block(start++, obj)) {
            return;
        }
    }
}

NSArray* HTFilter(BOOL(^block)(id obj), HTIterable iterable){
    NSMutableArray* array = [NSMutableArray array];
    for (id element in iterable) {
        if (block(element)) {
            [array addObject:element];
        }
    }
    return [NSArray arrayWithArray:array];
}

BOOL HTIsinstance(id obj, HTIterable classes){
    return HTXMap(^id(id cls) {
        return [NSNumber numberWithBool:[obj isKindOfClass:cls]];
    }, classes, ^BOOL(id boolObj) {
        return HTBool(boolObj);
    });
}

BOOL HTIssubclass(Class cls, HTIterable classes){
    return HTXMap(^id(id obj) {
        return [NSNumber numberWithBool:[cls isSubclassOfClass:obj]];
    }, classes, ^BOOL(id boolObj) {
        return HTBool(boolObj);
    });
}

NSArray* HTArray(HTIterable iterable){
    return HTMap(^id(id obj) {
        return obj;
    }, iterable);
}
NSArray* HTMap(id(^block)(id obj), HTIterable iterable){
    NSMutableArray* array = [NSMutableArray array];
    for (id element in iterable) {
        [array addObject:block(element)];
    }
    return [NSArray arrayWithArray:array];
}
id HTMax(NSComparisonResult(^block)(id first, id second), id first, ...){
    va_list list;
    va_start(list, first);
    if (first == nil) {
        return nil;
    }
    id max = va_arg(list, id);
    id next = va_arg(list, id);
    while(next) {
        NSComparisonResult r = block(max, next);
        if (r == NSOrderedAscending) {
            max = next;
        }
    }
    va_end(list);
    return max;
}

id HTMin(NSComparisonResult(^block)(id first, id second), id first, ... ){
    va_list list;
    va_start(list, first);
    if (first == nil) {
        return nil;
    }
    id min = va_arg(list, id);
    id next = va_arg(list, id);
    while(next) {
        NSComparisonResult r = block(min, next);
        if (r == NSOrderedDescending) {
            min = next;
        }
    }
    va_end(list);
    return min;
}

NSArray* HTRange(NSInteger stop){
    return HTRangeStart(0, stop);
}

NSArray* HTRangeStart(NSInteger start, NSInteger stop){
    return HTRangeStep(start, stop, 1);
}

NSArray* HTRangeStep(NSInteger start, NSInteger stop, NSInteger step){
    NSMutableArray* array = [NSMutableArray array];
    for (; start < stop; start += step) {
        [array addObject:[NSNumber numberWithInteger:start]];
    }
    return [NSArray arrayWithArray:array];
}

HTIterable HTReversed(HTIterable iterable){
    if ([iterable respondsToSelector:@selector(reverseObjectEnumerator)]) {
        return [iterable performSelector:@selector(reverseObjectEnumerator)];
    }
    return [HTArray(iterable) reverseObjectEnumerator];
}

id HTSum(HTIterable iterable){
    NSDecimalNumber* sum = [NSDecimalNumber zero];
    for (NSNumber* element in iterable) {
        sum = [sum decimalNumberByAdding:[[NSDecimalNumber alloc] initWithDecimal:[element decimalValue]]];
    }
    return sum;
}

BOOL HTXMap(id(^mapBlock)(id obj), HTIterable iterable, BOOL(^block)(id obj)){
    for (id element in iterable) {
        if(!block(mapBlock(element))){
            return NO;
        }
    }
    return YES;
}

HTIterable HTChain(HTIterable iterables){
    NSMutableArray* array = [NSMutableArray array];
    for (HTIterable iterable in iterables) {
        [array addObject:HTArray(iterable)];
    }
    return [NSArray arrayWithArray:array];
}