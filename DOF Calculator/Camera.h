//
//  Camera.h
//  DOF Calculator
//
//  Created by Christoph Zirkelbach on 06.03.13.
//

#import <Foundation/Foundation.h>

@interface Camera : NSObject

// properties
@property NSString *make, *model;
@property (nonatomic) double factor; // crop factor to 35mm format

// special inits
- (id)initWithMake:(NSString*)make model:(NSString*)model factor:(double)factor;

@end
