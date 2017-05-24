//
//  ViewController.m
//  WSSignatureView
//
//  Created by LK on 21/05/2017.
//  Copyright © 2017 WebsoftProfession. All rights reserved.
//

#import "ViewController.h"
#import "WSSignature.h"

@interface ViewController ()
{
    __weak IBOutlet WSSignature *signature;
    
    __weak IBOutlet UIImageView *imgSignature;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)captureSignature:(id)sender {
    
    imgSignature.image = [signature captureSignature];
    [signature clearSignaturePad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
