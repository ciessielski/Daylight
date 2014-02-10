//
//  SCViewController.m
//  Sun Clock
//
//  Created by Michał on 28.12.2012.
//  Copyright (c) 2012 Michał Ciesielski. All rights reserved.
//

#import "SCViewController.h"
#import <Math.h>

@interface SCViewController ()



@end


@implementation SCViewController

@synthesize locationManager;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //pobieranie lokalizacji
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [locationManager startUpdatingLocation];
    
    //pobieranie elementów daty
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    
    //kod liczący wschody i zachody słońca
    int R = [components year];
    int M = [components month];
    int D = [components day];
    double Lat = locationManager.location.coordinate.latitude;   //szerokosc geograficzna    ujemna - S  dodatnia - N
    double Long = locationManager.location.coordinate.longitude; //dlugosc geograficzna      ujemna - W  dodatnia - E
    double Req=-0.833; //wysokosc Slonca podczas Wschodu i Zachodu
    double J = 367*R- (7*(R+((M+9)/12))/4)+(275*M/9)+D-730531.5;
    double Cent=J/36525;
    double L = fmod((4.8949504201433+628.331969753199*Cent),6.28318530718); //
    double G=fmod((6.2400408+628.3019501*Cent),6.28318530718);
    double O=0.409093-0.0002269*Cent;
    double F=0.033423*sin(G)+0.00034907*sin(2*G);
    double E=0.0430398*sin(2*(L+F)) - 0.00092502*sin(4*(L+F)) - F;
    double A=asin(sin(O)*sin(L+F));
    double C=(sin(0.017453293*Req) - sin(0.017453293*Lat)*cos(A))/(cos(0.017453293*Lat)*cos(A));
    double Tran=(M_PI - (E+0.017453293*Long))*57.29577951/15;
    
    NSLog(@"rok:%d miesiac:%d dzien:%d",R, M, D);
    NSLog(@"gt = %e %e %e", C, E, A);
    NSLog(@" %f %e", Tran, Tran);
    
    NSLog(@"długość:%f szerokość:%f", Long, Lat);
    
   

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
