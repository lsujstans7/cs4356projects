//
//  ViewController.m
//  cs4356projects
//
//  Created by Johnathan Stansbury on 10/12/12.
//  Copyright (c) 2012 LSU. All rights reserved.
//

#import "ViewController.h"
#import "Project1Cell.h"
#import "Project1GLKitViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize optionsTableView;
@synthesize options = _options;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.options = [NSMutableArray array];
    
    [self.options addObject:@"747"];
    [self.options addObject:@"icosahedron"];
    [self.options addObject:@"bunny"];
    [self.options addObject:@"square"];
    [self.options addObject:@"teapot"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableview numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%d", self.options.count);
    return self.options.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Project1Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"Project1Cell"];
    NSString *instance = [self.options objectAtIndex:indexPath.row];
    cell.project1CellLabel.text = instance;
    return cell;
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"GLSegue"]) {
        Project1GLKitViewController *glVC = segue.destinationViewController;
        NSIndexPath *indexPath = [self.optionsTableView indexPathForSelectedRow];
        glVC.meshName = [self.options objectAtIndex:indexPath.row];
        [self.optionsTableView deselectRowAtIndexPath:indexPath animated:YES];
        
    }
}


@end
