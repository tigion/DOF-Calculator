//
//  CameraInfos.h
//  DOF Calculator
//
//  Created by Christoph Zirkelbach on 06.03.13.
//

#import <Foundation/Foundation.h>

@class Camera;

@interface CameraInfos : NSObject

// properties
@property (readonly) NSMutableArray* cameras;

// methods
- (void)loadCameraInfos;

@end
