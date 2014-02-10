//
//  SCViewController.h
//  Sun Clock
//
//  Created by Michał on 28.12.2012.
//  Copyright (c) 2012 Michał Ciesielski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>



@interface SCViewController : UIViewController

@property (strong, nonatomic) IBOutlet CLLocationManager *locationManager;


@end
