//
//  COF.m
//  DOF Calculator
//
//  Created by Christoph Zirkelbach on 20.01.10.
//

#import "DOF.h"

@implementation DOF

// init

- (id)init {
    if (self = [super init]) {
        self->_factor = 0;
        self->_focale = 0;
        self->_aperture = 0;
        self->_distance = 0;
        self->_hyperfocalDistance = 0;
        self->_minSharpDistance = 0;
        self->_maxSharpDistance = 0;
        self->_areaSharpZone = 0;
    }
    return self;
}

// special inits

- (id)initWithFactor:(double)factor focale:(double)focale aperture:(double)aperture distance:(double)distance {
    if (self = [super init]) {
        self->_factor = (factor > 0) ? factor : 0;
        self->_focale = (focale > 0) ? focale : 0;
        self->_aperture = (aperture > 0) ? aperture : 0;
        self->_distance = (distance > 0) ? distance : 0;
        [self calcAll];
    }
    return self;
}

// special setter

- (void)setFactor:(double)factor {
    if (self->_factor != factor) {
        self->_factor = (factor > 0) ? factor : 0;
        [self calcAll];
    }
}

- (void)setFocale:(double)focale {
    if (self->_focale != focale) {
        self->_focale = (focale > 0) ? focale : 0;
        [self calcAll];
    }
}

- (void)setAperture:(double)aperture {
    if (self->_aperture != aperture) {
        self->_aperture = (aperture > 0) ? aperture : 0;
        [self calcAll];
    }
}

- (void)setDistance:(double)distance {
    if (self->_distance != distance) {
        self->_distance = (distance > 0) ? distance : 0;
        [self calcMinSharpDistance];
        [self calcMaxSharpDistance];
        [self calcAreaSharpZone];
    }
}

// methods

// calc hyperfocal distance
- (void)calcHyperfocalDistance {
	if (self.factor == 0 || self.focale == 0 || self.aperture == 0)
		self->_hyperfocalDistance = 0;
    else
        self->_hyperfocalDistance = ((self.focale * self.focale) / (self.aperture * (0.03 / self.factor))) + self.focale;
}

// calc min sharp distance
- (void)calcMinSharpDistance {
	if (self.factor == 0 || self.focale == 0 || self.aperture == 0 || self.distance == 0)
		self->_minSharpDistance = 0;
    else if (self.distance < self.focale)
        self->_minSharpDistance = self.distance;
	else
        self->_minSharpDistance = (self.distance * self.hyperfocalDistance) / (self.hyperfocalDistance + (self.distance - self.focale));
}

// calc max sharp distance
- (void)calcMaxSharpDistance {
	if (self.factor == 0 || self.focale == 0 || self.aperture == 0 || self.distance == 0)
		self->_maxSharpDistance = 0;
    else if (self.distance < self.focale)
        self->_maxSharpDistance = self.distance;
    else if (self.hyperfocalDistance > (self.distance - self.focale))
		self->_maxSharpDistance = (self.distance * self.hyperfocalDistance) / (self.hyperfocalDistance - (self.distance - self.focale));
	else
		self->_maxSharpDistance = INFINITY;
}

// calc sharp zone area
- (void)calcAreaSharpZone {
	if (self.factor == 0 || self.focale == 0 || self.aperture == 0 || self.distance == 0)
		self->_areaSharpZone = 0;
	else
        self->_areaSharpZone = self.maxSharpDistance - self.minSharpDistance;
}

// calc all
- (void)calcAll {
    [self calcHyperfocalDistance];
    [self calcMinSharpDistance];
    [self calcMaxSharpDistance];
    [self calcAreaSharpZone];
}

@end
