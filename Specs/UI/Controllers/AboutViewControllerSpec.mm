#import "AboutViewController.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(AboutViewControllerSpec)

describe(@"AboutViewController", ^{
    __block AboutViewController *controller;
    __block NSArray *cheerleaders;

    beforeEach(^{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        controller = [storyboard instantiateViewControllerWithIdentifier:@"AboutViewController"];
        
        NSString *pathForResource = [[NSBundle mainBundle] pathForResource:@"cheerleaders" ofType:@"plist"];
        cheerleaders = [NSArray arrayWithContentsOfFile:pathForResource];

        controller.view should_not be_nil;
        
        UIViewController *rootController = [storyboard instantiateInitialViewController];
        NSLog(@"================> %@", rootController);
    });
    
    describe(@"outlets", ^{
        describe(@"tableView", ^{
            fit(@"should exist", ^{
                controller.tableView should_not be_nil;
            });
        });
    });
    
    describe(@"UITableViewDataSource Protocol", ^{
        describe(@"numberOfSectionsInTableView:", ^{
            it(@"should be one", ^{
                [controller numberOfSectionsInTableView:controller.tableView] should equal(1);
            });
        });
        
        describe(@"numberofRowsInSection:", ^{
            it(@"should have the same number of rows as the cheerleaders", ^{
                [controller tableView:controller.tableView numberOfRowsInSection:1] should equal(cheerleaders.count);
            });
        });
        
        describe(@"tableView:cellForRowAtIndexPath:", ^{
            __block UITableViewCell *cell;
            
            beforeEach(^{
                cell = [controller tableView:controller.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
            });
            
            it(@"should set the name correctly", ^{
                cell.textLabel.text should equal([cheerleaders[2] objectForKey:@"name"]);
            });
        });
    });
    
    describe(@"TabBarController", ^{
        __block UITabBarController *tabBarController;
        
        beforeEach(^{
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            tabBarController = [storyboard instantiateInitialViewController];
        });
        
        it(@"should be a tabBarController", ^{
            tabBarController should be_instance_of([UITabBarController class]);
        });
        
        
    });
});

SPEC_END
