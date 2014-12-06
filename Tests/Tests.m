//
//  Tests.m
//  Tests
//
//  Created by Markus Kauppila on 06/12/14.
//
//

#import <Quick/Quick.h>
#import <Nimble/Nimble.h>

QuickSpecBegin(Test)

describe(@"Test", ^{
    it(@"zero should not be one", ^{
        expect(@(0)).toNot(equal(@(1)));
    });
});


QuickSpecEnd;
