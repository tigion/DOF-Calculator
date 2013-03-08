//
//  Camera.m
//  DOF Calculator
//
//  Created by Christoph Zirkelbach on 06.03.13.
//

#import "Camera.h"

@implementation Camera

// init

- (id)init {
    if (self = [super init]) {
        self->_factor = 0;
    }
    return self;
}

// special inits

- (id)initWithMake:(NSString*)make model:(NSString*)model factor:(double)factor {
    if (self = [super init]) {
        self->_make = make;
        self->_model = model;
        self.factor = factor;
    }
    return self;
}

// special setter

- (void)setFactor:(double)factor {
    self->_factor = (factor > 0) ? factor : 0;
}

@end
