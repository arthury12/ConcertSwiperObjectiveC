//
//  matchesTableVC.m
//  concertSwiper
//
//  Created by Arthur Yu on 2/23/16.
//  Copyright © 2016 Arthur Yu. All rights reserved.
//

#import "matchesTableVC.h"

@interface matchesTableVC () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation matchesTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

//- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
