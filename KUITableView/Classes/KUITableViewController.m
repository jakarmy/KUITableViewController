//
//  ViewController.m
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

#import "KUITableViewController.h"
#import "Constants.h"
#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>

static char * const myIndexPathAssociationKey = "";

@interface KUITableViewController ()

@end

@implementation KUITableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    if (!_tableViewData) {
        _tableViewData = [[NSMutableArray alloc] init];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    Configure this. . .
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary *sectionInformation = [_tableViewData objectAtIndex:section];
    NSArray *rowsInformation = [sectionInformation objectForKey:K_SECTION_DATA];

    return [rowsInformation count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_tableViewData count];
}

// You can add to _tableViewData information related to cell height, but this is easily customizable in storyboard using a prototype cell, and changing height manually

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDictionary *sectionInformation = [_tableViewData objectAtIndex:section];
    return [sectionInformation objectForKey:K_SECTION_HEADER_TITLE];
}

- (NSString *) tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{

    NSDictionary *sectionInformation = [_tableViewData objectAtIndex:section];
    return [sectionInformation objectForKey:K_SECTION_FOOTER_TITLE];
}

- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    NSDictionary *sectionInformation = [_tableViewData objectAtIndex:section];
    return [sectionInformation objectForKey:K_SECTION_FOOTER_VIEW];
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSDictionary *sectionInformation = [_tableViewData objectAtIndex:section];
    return [sectionInformation objectForKey:K_SECTION_HEADER_VIEW];
}

#pragma mark TableViewCell methods

- (void) customizeCellAccessoryView:(UITableViewCell *)cell withIdentifier:(NSString *)cellIdentifier atIndexPath:(NSIndexPath *)indexPath{
//    if ([cellIdentifier isEqualToString:K_FRIENDS_CELL_IDENTIFIER]) {
//        // Add some image as an accessory view
//    }
}

- (void) addPlaceholderThumbnailForCell:(UITableViewCell *)cell withIdentifier:(NSString *)cellIdentifier atIndexPath:(NSIndexPath *)indexPath{
    cell.imageView.image = [UIImage imageNamed:@"thumbnail_placeholder.png"];
}

- (void)customizeCell:(UITableViewCell *)cell withIdentifier:(NSString *)cellIdentifier atIndexPath:(NSIndexPath *)indexPath{
//  You can change this customization behavior according to each cellIdentifier value.
    //    if ([cellIdentifier isEqualToString:K_FRIENDS_CELL_IDENTIFIER]) {
    //        // Customize appearance
    //    }

    cell.textLabel.adjustsFontSizeToFitWidth = YES;

    cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;

    cell.imageView.layer.cornerRadius = 7.0;
    cell.imageView.clipsToBounds = YES;
}

// The following code snippet loads an image asynchronously from an URL.
// Source: http://stackoverflow.com/questions/8087010/loading-image-in-uitableviewcell-asynchronously

- (void) loadImageViewForCell:(UITableViewCell *)cell withImageURL:(NSString *)imageURL atIndexPath:(NSIndexPath *)indexPath{
    objc_setAssociatedObject(cell,
                             myIndexPathAssociationKey,
                             indexPath,
                             OBJC_ASSOCIATION_RETAIN);

    //            Evaluate if this is actually working, once the cell gets out of the bounds.
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_async(queue, ^{
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
        UIImage *image = [UIImage imageWithData:imageData];
        // Code to actually update the cell once the image is obtained must be run on the main queue.
        if (image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSIndexPath *cellIndexPath = (NSIndexPath *)objc_getAssociatedObject(cell, myIndexPathAssociationKey);
                if ([indexPath isEqual:cellIndexPath]) {
                    // Only set cell image if the cell currently being displayed is the one that actually required this image.
                    // Prevents reused cells from receiving images back from rendering that were requested for that cell in a previous life.
                    cell.imageView.image = image;
                }
            });
        }
    });
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *cellInformation = [[[_tableViewData objectAtIndex:indexPath.section] objectForKey:K_SECTION_DATA] objectAtIndex:indexPath.row];
    NSString *cellIdentifier = [cellInformation objectForKey:K_CELL_IDENTIFIER];

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

//    Here we are assuming that UITableViewCellStyleSubtitle will be a format wide enough to cover most needs
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }

    [self customizeCell:cell withIdentifier:cellIdentifier atIndexPath:indexPath];
    [self addPlaceholderThumbnailForCell:cell withIdentifier:cellIdentifier atIndexPath:indexPath];
    [self customizeCellAccessoryView:cell withIdentifier:cellIdentifier atIndexPath:indexPath];


//    Here we set the text label checking for one of the two possible text values
    if ([cellInformation objectForKey:K_CELL_TEXT]) {
        cell.textLabel.text = [cellInformation objectForKey:K_CELL_TEXT];
    }else{
        cell.textLabel.attributedText = [cellInformation objectForKey:K_CELL_ATTRIBUTED_TEXT];
    }
    cell.textLabel.font = [cell.textLabel.font fontWithSize:[[cellInformation objectForKey:K_CELL_TEXT_FONT_SIZE] floatValue]];

//    Here we set the detail text label checking for one of the two possible text values
    if ([cellInformation objectForKey:K_CELL_DETAIL_TEXT]) {
        cell.detailTextLabel.text = [cellInformation objectForKey:K_CELL_DETAIL_TEXT];
    }else{
        cell.detailTextLabel.attributedText = [cellInformation objectForKey:K_CELL_DETAIL_ATTRIBUTED_TEXT];
    }
    cell.detailTextLabel.font = [cell.detailTextLabel.font fontWithSize:[[cellInformation objectForKey:K_CELL_DETAIL_TEXT_FONT_SIZE] floatValue]];

//    Here we set the image, checking for an image name (included as an image file inside the bundle) or an image url, in which case we would set an asynchronous fetch
    if ([cellInformation objectForKey:K_CELL_IMAGE_NAME]) {
        cell.imageView.image = [UIImage imageNamed:[cellInformation objectForKey:K_CELL_IMAGE_NAME]];
    }else{
        [self loadImageViewForCell:cell withImageURL:[cellInformation objectForKey:K_CELL_IMAGE_URL] atIndexPath:indexPath];
    }

    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // NSString *reuseIdentifier = ((UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath]).reuseIdentifier;

//    if ([reuseIdentifier isEqualToString:K_FRIENDS_CELL_IDENTIFIER]) {
//          // Do some custom behavior
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
