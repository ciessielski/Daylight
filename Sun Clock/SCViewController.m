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
    double Req = -0.833; //wysokosc Slonca podczas Wschodu i Zachod
    
    double J = 367*R - (7*(R+((M+9)/12))/4)+(275*M/9)+D-730531.5;
    double Cent = J/36525;
    double L = fmod((4.8949504201433+628.331969753199*Cent),6.28318530718); //
    double G = fmod((6.2400408+628.3019501*Cent),6.28318530718);
    double O = 0.409093-0.0002269*Cent;
    double F = 0.033423*sin(G)+0.00034907*sin(2*G);
    double E = 0.0430398*sin(2*(L+F)) - 0.00092502*sin(4*(L+F)) - F;
    double A = asin(sin(O)*sin(L+F));
    double C = (sin(0.017453293*Req)-sin(0.017453293*Lat)*sin(A))/(cos(0.017453293*Lat)*cos(A));
    
    double sunrise = (M_PI - (E + 0.017453293*Long + acos(C)))*57.29577951/15;
    double sunset = (M_PI - (E + 0.017453293*Long + (-1)*acos(C)))*57.29577951/15;
    
    NSLog(@"J:%f", J);
    NSLog(@"Cent:%f", Cent);
    NSLog(@"L:%f", L);
    NSLog(@"G:%f", G);
    NSLog(@"O:%f", O);
    NSLog(@"F:%f", F);
    NSLog(@"E:%f", E);
    NSLog(@"A:%f", A);
    NSLog(@"C:%f", C);



    
    NSLog(@"długość:%f szerokość:%f", Long, Lat);
    NSLog(@"rok:%d miesiac:%d dzien:%d",R, M, D);

    
    NSLog(@"sunrise: %f",sunrise);
    NSLog(@"sunset: %f",sunset);
//    NSLog(@"gt = %f %f %f", C, E, A);
    
    
    //strefy czasowe
    NSTimeZone* deviceTimeZone_ = [NSTimeZone systemTimeZone];
    float offset = [deviceTimeZone_ secondsFromGMTForDate:[NSDate date]] / 3600.0;
    NSLog(@"Timezone: %f",offset);
    
    
    //przerabianie obliczeń na godziny
    int sunriseHour = sunrise;
    int sunriseMinutes = ((sunrise - sunriseHour)*60);
    
    int sunsetHour = sunset;
    int sunsetMinutes = ((sunset - sunsetHour)*60);
    
    NSLog(@"sunrise: %d:%d",sunriseHour,sunriseMinutes);
    NSLog(@"sunset: %d:%d",sunsetHour,sunsetMinutes);
    
   

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
