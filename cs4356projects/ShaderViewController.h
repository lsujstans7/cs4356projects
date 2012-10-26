//
//  ShaderViewController.h
//  cs4356projects
//
//  Created by Johnathan Stansbury on 10/26/12.
//  Copyright (c) 2012 LSU. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShaderViewController;
@protocol ShaderViewControllerDelegate <NSObject>

-(void)shaderViewController:(ShaderViewController *)shaderVC didSaveOption:(NSString *)newShader;

@end

@interface ShaderViewController : UITableViewController

@property (weak, nonatomic) id <ShaderViewControllerDelegate> delegate;

@property (nonatomic, strong) NSMutableArray *shaders;

@end
