//
//  AppDelegate.h
//  DOF Calculator
//
//  Created by Christoph Zirkelbach on 24.02.13.
//

#import <Cocoa/Cocoa.h>

@class CameraInfos;
@class DOF;

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    // attributs
    DOF *_dof;
}

// window outlet
@property (assign) IBOutlet NSWindow *window;

// toolbar outlets
@property (weak) IBOutlet NSPopUpButton *cameraPopUpButton;

// input outlets
@property (weak) IBOutlet NSTextField *factorTextField;
@property (weak) IBOutlet NSTextField *focaleTextField;
@property (weak) IBOutlet NSComboBox *apertureComboBox;
@property (weak) IBOutlet NSTextField *distanceTextField;
@property (weak) IBOutlet NSPopUpButton *distanceUnitButton;

// output outlets
@property (weak) IBOutlet NSTextField *minSharpDistanceTextField;
@property (weak) IBOutlet NSTextField *minSharpDistanceUnitTextField;
@property (weak) IBOutlet NSTextField *maxSharpDistanceTextField;
@property (weak) IBOutlet NSTextField *maxSharpDistanceUnitTextField;
@property (weak) IBOutlet NSTextField *areaSharpZoneTextField;
@property (weak) IBOutlet NSTextField *areaSharpZoneUnitTextField;
@property (weak) IBOutlet NSLevelIndicator *areaSharpZoneLevelIndicator;
@property (weak) IBOutlet NSTextField *hyperfocalDistanceTextField;
@property (weak) IBOutlet NSTextField *hyperfocalDistanceUnitTextField;

// action methods
- (IBAction)changeCameraModell:(id)sender;
- (IBAction)changeAperture:(id)sender;
- (IBAction)changeDistanceUnit:(id)sender;

// methods
- (double)convertDistanceTo_mm:(double)value;
- (double)humanReadableResult:(double)value;
- (NSString*)unitForHumanReadableResult:(double)value;
- (void)refreshResults;

@end
