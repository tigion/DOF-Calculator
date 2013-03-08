//
//  DOF.h
//  DOF Calculator
//
//  Created by Christoph Zirkelbach on 20.01.10.
//
//  Notes:
//  - calculation in 'mm': focale, distance
//  - results in     'mm': hyperfocalDistance, minSharpDistance, maxSharpDistance, areaSharpZone

#import <Foundation/Foundation.h>

@interface DOF : NSObject

// properties
@property(nonatomic) double factor, focale, aperture, distance;
@property(readonly) double hyperfocalDistance, minSharpDistance, maxSharpDistance, areaSharpZone;

// special inits
- (id)initWithFactor:(double)factor focale:(double)focale aperture:(double)aperture distance:(double)distance;

// methods
- (void)calcHyperfocalDistance;
- (void)calcMinSharpDistance;
- (void)calcMaxSharpDistance;
- (void)calcAreaSharpZone;
- (void)calcAll;

@end
