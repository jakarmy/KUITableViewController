//
//  InitialViewController.m
//  KTableView
//
//  Created by Juan Antonio Karmy on 07-08-13.
//  Copyright (c) 2013 Juan Antonio Karmy. All rights reserved.
//

// The MIT License (MIT)

// Copyright (c) 2013 Juan Antonio Karmy

// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
// the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "InitialViewController.h"
#import "KUITableViewController.h"
#import "Constants.h"

@interface InitialViewController ()

@end

@implementation InitialViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
- (IBAction)buildKUITableViewData:(id)sender {
    NSMutableArray *tableViewData = [[NSMutableArray alloc] init];

    NSMutableDictionary *cellInformation = [[NSMutableDictionary alloc] init];
    [cellInformation setValue:@"FriendsCell" forKey:K_CELL_IDENTIFIER];
    [cellInformation setValue:@"John Appleseed" forKey:K_CELL_TEXT];
    [cellInformation setValue:[NSNumber numberWithFloat:14] forKey:K_CELL_TEXT_FONT_SIZE];
    [cellInformation setValue:@"joined 3 days ago" forKey:K_CELL_DETAIL_TEXT];
    [cellInformation setValue:[NSNumber numberWithFloat:14] forKey:K_CELL_DETAIL_TEXT_FONT_SIZE];
    [cellInformation setValue:@"http://mrmusicoh.squarespace.com/storage/person%20placeholder.png?__SQUARESPACE_CACHEVERSION=1283659124407" forKey:K_CELL_IMAGE_URL];

    NSMutableArray *sectionCells = [[NSMutableArray alloc] init];
    [sectionCells addObject:cellInformation];

    NSMutableDictionary *firstSection = [[NSMutableDictionary alloc] init];
    [firstSection setValue:@"Friends" forKey:K_SECTION_HEADER_TITLE];
    [firstSection setValue:nil forKey:K_SECTION_HEADER_VIEW];
    [firstSection setValue:@"" forKey:K_SECTION_FOOTER_TITLE];
    [firstSection setValue:nil forKey:K_SECTION_FOOTER_VIEW];
    [firstSection setValue:sectionCells forKey:K_SECTION_DATA];

    [tableViewData addObject:firstSection];

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    KUITableViewController *KUITableViewController = [storyboard instantiateViewControllerWithIdentifier:@"KUITableViewController"];

    KUITableViewController.tableViewData =tableViewData;

    [self.navigationController pushViewController:KUITableViewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
