HTPyFunctions --- Python-like functions in Objective-C
======================================================

HTPyFunctions provides fuctions like some built in functions in Python. 

For example it provides `map` function like

    NSArray* descriptions = HTMap(^id(id obj) {
        return [obj description];
    }, array);

You can find code in https://github.com/Hardtack/HTPyFunctions
