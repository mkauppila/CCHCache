//
//  CCHMemoryCacheSpec.m
//  CCHCache
//
//  Created by Markus Kauppila on 07/12/14.
//
//

#import <Quick/Quick.h>
#import <Nimble/Nimble.h>

QuickSpecBegin(MemoryCache)

describe(@"Test", ^{
    it(@"zero should not be one", ^{
        expect(@(0)).toNot(equal(@(1)));
    });
});


QuickSpecEnd;
