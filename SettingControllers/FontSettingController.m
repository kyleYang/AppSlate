//
//  FontSettingController.m
//  AppSlate
//
//  Created by 김 태한 on 11. 12. 29..
//  Copyright (c) 2011년 ChocolateSoft. All rights reserved.
//

#import "FontSettingController.h"

@interface FontSettingController ()

@end

@implementation FontSettingController

- (id)initWithGear:(id)gear propertyInfo:(NSDictionary*)infoDic
{
    self = [super init];

    theGear = gear;
    pInfoDic = infoDic;

    if (self) {
        // Custom initialization
        self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 300)];
        SEL selector = [[pInfoDic objectForKey:@"getSelector"] pointerValue];
        UIFont *fnt = [theGear performSelector:selector];
        cmtController = [CMTextStylePickerViewController textStylePickerViewController];
        [cmtController fontSelectTableViewController:nil didSelectFont:fnt];
        [self addChildViewController:cmtController];
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
    [cmtController viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void)viewWillAppear:(BOOL)animated
{
    CGSize size = CGSizeMake(320, 219); // size of view in popover
    self.contentSizeForViewInPopover = size;

    [cmtController.view setFrame:self.view.frame];
    [cmtController viewWillAppear:animated];
    [self.view addSubview:cmtController.view];

    saveBtn = [[BButton alloc] initWithFrame:CGRectMake(C_GAP, 150.0+(C_GAP*3), C_WIDTH, 40)];
    [saveBtn setTitle:NSLocalizedString(@"APPLY",@"APPLY")];
    [saveBtn addTarget:self action:@selector(setTheValue:)];
//    [saveBtn setEnabled:YES];
    [cmtController.view addSubview:saveBtn];

    [super viewWillAppear:animated];
}

// UIPopover Controller 의 크기를 조정해주기 위해서 사용하는 팁 같은 코드.
-(void) viewDidAppear:(BOOL)animated
{
    CGSize currentSetSizeForPopover = self.contentSizeForViewInPopover;
    CGSize fakeMomentarySize = CGSizeMake(currentSetSizeForPopover.width - 1.0f, currentSetSizeForPopover.height - 1.0f);
    self.contentSizeForViewInPopover = fakeMomentarySize;
    self.contentSizeForViewInPopover = currentSetSizeForPopover;
}

#pragma mark - Setting Button Action

-(void) setTheValue:(id)sender
{
    [self saveValue:cmtController.selectedFont];
}

@end
