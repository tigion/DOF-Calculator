//
//  CameraInfos.m
//  DOF Calculator
//
//  Created by Christoph Zirkelbach on 06.03.13.
//

#import "CameraInfos.h"
#import "Camera.h"

@implementation CameraInfos

// init

- (id)init {
    if (self = [super init]) {
        self->_cameras = [[NSMutableArray alloc] init];
        [self loadCameraInfos];
    }
    return self;
}

// methods

- (void)loadCameraInfos {
    // simple hard coded
    // source: http://en.wikipedia.org/wiki/Crop_factor
    [self.cameras addObject:[[Camera alloc] initWithMake:@"Full Frame" model:@""           factor:1.0]];
    [self.cameras addObject:[[Camera alloc] initWithMake:@"Canon"      model:@"(APS-H)"    factor:1.3]];
    [self.cameras addObject:[[Camera alloc] initWithMake:@"Canon"      model:@"(APS-C)"    factor:1.6]];
    [self.cameras addObject:[[Camera alloc] initWithMake:@"Leica"      model:@"M8"         factor:1.3]];
    [self.cameras addObject:[[Camera alloc] initWithMake:@"Nikon"      model:@"DX (APS-C)" factor:1.5]];
    [self.cameras addObject:[[Camera alloc] initWithMake:@"Olympus"    model:@""           factor:2.0]];
    [self.cameras addObject:[[Camera alloc] initWithMake:@"Pentax"     model:@"K (APS-C)"  factor:1.5]];
    [self.cameras addObject:[[Camera alloc] initWithMake:@"Samsung"    model:@"NX (APS-C)" factor:1.5]];
    [self.cameras addObject:[[Camera alloc] initWithMake:@"Sony"       model:@"Alpha"      factor:1.5]];
}

@end
