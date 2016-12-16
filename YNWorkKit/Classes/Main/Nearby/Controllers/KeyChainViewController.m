//
//  KeyChainViewController.m
//  YNWorkKit
//
//  Created by zyn on 2016/11/29.
//  Copyright © 2016年 张艳能. All rights reserved.
//

#import "KeyChainViewController.h"
#import "KeychainWrapper.h"
#import "SecurityUtil.h"

@interface KeyChainViewController ()

@property (weak, nonatomic) IBOutlet UILabel *saveUUID;

@property (weak, nonatomic) IBOutlet UILabel *readUUID;

@end

@implementation KeyChainViewController


- (instancetype)init {
    
    KeyChainViewController *keyVC = [[KeyChainViewController alloc] initWithNibName:@"KeyChainViewController" bundle:nil];
    
    return keyVC;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.saveUUID.text = [SecurityUtil createUUID];
    
}

- (IBAction)save:(UIButton *)sender {
    
    KeychainWrapper *keychain =  [KeychainWrapper defaultWrapper];
    
   BOOL isSuccesss =  [keychain setObject:self.saveUUID.text forKey:@"uuidkey"];
    NSLog(@"%zd",isSuccesss);
    
}

- (IBAction)read:(UIButton *)sender {
    
    KeychainWrapper *keychain =  [KeychainWrapper defaultWrapper];
    
    NSString *uuid = [keychain objectForKey:@"uuidkey"];
    
    self.readUUID.text = uuid;
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
