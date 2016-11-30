//
//  TabControl.m
//  GameDevDocs
//
//  Created by Brendan Campbell on 1/1/15.
//  Copyright (c) 2015 Wolverine Games LLC. All rights reserved.
//

#import "TabControl.h"

@interface TabControl ()

@end

@implementation TabControl

- (void)viewDidLoad {
    [super viewDidLoad];
    for (UITabBarItem *tbi in self.tabBar.items) {
        tbi.image = [tbi.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    [[self tabBar]setTintColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
