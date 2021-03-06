//
//  FileGalleryController.m
//  AppSlate
//
//  Created by Taehan Kim 태한 김 on 12. 1. 18..
//  Copyright (c) 2012년 ChocolateSoft. All rights reserved.
//

#import "FileGalleryController.h"

@interface FileGalleryController ()

@end

@implementation FileGalleryController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        toolbar = nil; bookshelfVC = nil;
        self.view = [[UIView alloc] init];
    }
    return self;
}

- (void)loadView
{
    // Implement loadView to create a view hierarchy programmatically, without using a nib.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return( (interfaceOrientation == UIInterfaceOrientationPortrait) ||
           (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) );
}

-(void) viewWillAppear:(BOOL)animated
{
    if( nil == toolbar ){
        toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
        [toolbar setTintColor:[UIColor darkGrayColor]];

        UIBarButtonItem *closeBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(closeMe)];
        UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
//        UIBarButtonItem *sendBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(actionMode)];
        UIBarButtonItem *deleteBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(delMode)];

        [toolbar setItems:@[closeBtn,flexible,deleteBtn]];
        [self.view addSubview:toolbar];
    }

    // Bookshelf View Controller
    if( nil == bookshelfVC ){
        bookshelfVC = [[BookshelfViewController alloc] init];
        [bookshelfVC setParentController:self];
        [bookshelfVC.view setFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height-44)];
        [self.view addSubview:bookshelfVC.view];
    }

    mode = SELECTION;
}

#pragma mark - bar actions

- (void) closeMe
{
    if( SELECTION != mode )
    {
        mode = SELECTION;
        [bookshelfVC setMode:mode];

        UIBarButtonItem *closeBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(closeMe)];
        UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
//        UIBarButtonItem *sendBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(actionMode)];
        UIBarButtonItem *deleteBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(delMode)];
        
        [toolbar setItems:@[closeBtn,flexible,deleteBtn] animated:YES];

        return;
    }

    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void) delMode
{
    mode = DELETING;
    [bookshelfVC setMode:mode];

    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *closeBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(closeMe)];
    
    [toolbar setItems:@[flexible,closeBtn] animated:YES];
}

- (void) actionMode
{
    mode = SENDING;
    [bookshelfVC setMode:mode];
    
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *closeBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(closeMe)];
    
    [toolbar setItems:@[flexible,closeBtn] animated:YES];
}

@end
