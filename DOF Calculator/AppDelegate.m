//
//  AppDelegate.m
//  DOF Calculator
//
//  Created by Christoph Zirkelbach on 24.02.13.
//

#import "AppDelegate.h"
#import "CameraInfos.h"
#import "Camera.h"
#import "DOF.h"

@implementation AppDelegate

// ...

- (void)awakeFromNib
{
    // set delegates for 'controlTextDidChange'
    [_factorTextField setDelegate:(id)self];
    [_focaleTextField setDelegate:(id)self];
    [_apertureComboBox setDelegate:(id)self];
    [_distanceTextField setDelegate:(id)self];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	// init toolbar cameras
	[self.cameraPopUpButton removeAllItems];
	[self.cameraPopUpButton addItemWithTitle:@"Custom"];
    [[self.cameraPopUpButton menu] addItem: [NSMenuItem separatorItem]];
    for (Camera *camera in [[[CameraInfos alloc] init] cameras]) {
        NSString *title = [NSString stringWithFormat:@"%@ %@", [camera make], [camera model]];
        [self.cameraPopUpButton addItemWithTitle:title];
        [[self.cameraPopUpButton itemWithTitle:title] setRepresentedObject:camera];
    }
    
    // init apertures
    // source: http://de.wikipedia.org/wiki/Blendenreihe_(Optik)#Drittel-Blendenstufen
    float ap[] = {1.0, 1.1, 1.2, 1.4, 1.6, 1.7, 1.8, 2.0, 2.2, 2.4, 2.5, 2.8, 3.2, 3.4, 3.5, 3.6, 4.0, 4.5, 4.8, 5.0, 5.6, 6.3, 6.7, 7.1, 8.0, 9.0, 9.5, 10, 11, 13, 14, 16, 18, 19, 20, 22, 25, 29, 32, 36, 40, 45};
	int count = sizeof(ap)/sizeof(float);
	NSMutableArray *apertures = [[NSMutableArray alloc] init];
	for (int i = 0; i < count; i++)
		[apertures addObject:[[NSNumber alloc] initWithFloat:ap[i]]];
	[self.apertureComboBox addItemsWithObjectValues:apertures];
    
    // set sample data
    [self.factorTextField setDoubleValue:1.5];
    [self.focaleTextField setDoubleValue:50];
    [self.apertureComboBox setDoubleValue:1.4];
    [self.distanceTextField setDoubleValue:1.5];
    [self.distanceUnitButton selectItemWithTitle:@"m"];
    
    // init dof
    _dof = [[DOF alloc] initWithFactor:[self.factorTextField doubleValue] focale:[self.focaleTextField doubleValue] aperture:[self.apertureComboBox doubleValue] distance:[self convertDistanceTo_mm:[self.distanceTextField doubleValue]]];
    
    // refresh results
    [self refreshResults];
}

- (void)controlTextDidChange:(NSNotification *)notification {
    id sender = [notification object];
    bool refresh = true;
    
    // get new input as converted double value
    if (sender == self.factorTextField)
        [_dof setFactor:[sender doubleValue]];
    else if (sender == self.focaleTextField)
        [_dof setFocale:[sender doubleValue]];
    else if (sender == self.apertureComboBox)
        [_dof setAperture:[sender doubleValue]];
    else if (sender == self.distanceTextField)
        [_dof setDistance:[self convertDistanceTo_mm:[sender doubleValue]]];
    else
        refresh = false;
    
    // refresh results
    if (refresh)
        [self refreshResults];
}

// action methods

- (IBAction)changeCameraModell:(id)sender {
    Camera *camera = [[sender selectedItem] representedObject];

    if ([camera factor] <= 0)
        [self.factorTextField setEnabled:true];
    else {
        [self.factorTextField setEnabled:false];
        [self.factorTextField setDoubleValue:[camera factor]];
        [_dof setFactor:[camera factor]];
        [self refreshResults];
    }
}

- (IBAction)changeAperture:(id)sender {
    [_dof setAperture:[sender doubleValue]];
    [self refreshResults];
}

- (IBAction)changeDistanceUnit:(id)sender {
    [_dof setDistance:[self convertDistanceTo_mm:[sender doubleValue]]];
    [self refreshResults];
}

// methods

- (double)convertDistanceTo_mm:(double)value {
    if ([[self.distanceUnitButton titleOfSelectedItem] isEqual: @"km"])
        return value * 1000000.0; // km -> mm
    else if ([[self.distanceUnitButton titleOfSelectedItem] isEqual: @"m"])
        return value * 1000.0; // m -> mm
    else if ([[self.distanceUnitButton titleOfSelectedItem] isEqual: @"cm"])
        return value * 10.0; // cm -> mm
    else
        return value; // mm
}

- (double)humanReadableResult:(double)value {
    if (value >= 1000000)
        return value / 1000000.0; // km
    else if (value >= 1000)
        return value / 1000.0; // m
    else if (value >= 10)
        return value / 10.0; // cm
    else
        return value; // mm
}

- (NSString*)unitForHumanReadableResult:(double)value {
    if (value >= 1000000)
        return @"km"; // km
    else if (value >= 1000)
        return @"m"; // m
    else if (value >= 10)
        return @"cm"; // cm
    else
        return @"mm"; // mm
}

- (void)refreshResults {    
    [self.minSharpDistanceTextField setDoubleValue:[self humanReadableResult:[_dof minSharpDistance]]];
    [self.minSharpDistanceUnitTextField setStringValue:[self unitForHumanReadableResult:[_dof minSharpDistance]]];
    
    [self.maxSharpDistanceTextField setDoubleValue:[self humanReadableResult:[_dof maxSharpDistance]]];
    [self.maxSharpDistanceUnitTextField setStringValue:[self unitForHumanReadableResult:[_dof maxSharpDistance]]];
    
    [self.areaSharpZoneTextField setDoubleValue:[self humanReadableResult:[_dof areaSharpZone]]];
    [self.areaSharpZoneUnitTextField setStringValue:[self unitForHumanReadableResult:[_dof areaSharpZone]]];
    [self.areaSharpZoneLevelIndicator setDoubleValue:([_dof areaSharpZone] / 10.0)];
    
    [self.hyperfocalDistanceTextField setDoubleValue:[self humanReadableResult:[_dof hyperfocalDistance]]];
    [self.hyperfocalDistanceUnitTextField setStringValue:[self unitForHumanReadableResult:[_dof hyperfocalDistance]]];
}

@end
