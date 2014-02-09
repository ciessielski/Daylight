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

@property (weak, nonatomic) IBOutlet UILabel *dlugoscDnia;
@property (weak, nonatomic) IBOutlet UILabel *godzinaWschodu;
@property (weak, nonatomic) IBOutlet UILabel *ilePoWschodzie;
@property (weak, nonatomic) IBOutlet UILabel *godzinaZachodu;
@property (weak, nonatomic) IBOutlet UILabel *ileDoZachodu;
@property (weak, nonatomic) IBOutlet UILabel *wspolrzedne;

@end



@implementation SCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

int R = 2005;
int M=1;
int D=1;
double Lat=50.0;   //szerokosc geograficzna    ujemna - S  dodatnia - N
double Long=19.00; //dlugosc geograficzna      ujemna - W  dodatnia - E
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
    
//double Wsch=(M_PI - (E+0.017453293*Long + 1*acos(C)))*57.29577951/15;
double Tran=(M_PI - (E+0.017453293*Long))*57.29577951/15;
//double Zach=(M_PI - (E+0.017453293*Long + -1*acos(C)))*57.29577951/15;
    
    //NSLog(@"Wschod i Zachod Slonca dla");
    //NSLog(@"Miejscowosci :  Sze : ',Lat:0:2,' , Dlu : ',Long:0:2");
            NSLog(@"gt = %e %e %e", C, E, A);

  //  writeln('Czas UT');

    NSLog(@" %f %e", Tran, Tran);
 //   writeln('Tranzyt  :  ',int(Tran):0:0,':',(60*(Tran-int(Tran))):0:3,'     - Gorowanie');
   // writeln('ZachÛd   :  ',int(Zach):0:0,':',(60*(zach-int(Zach))):0:3);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
