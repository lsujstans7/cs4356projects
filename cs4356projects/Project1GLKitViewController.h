//
//  Project1GLKitViewController.h
//  cs4356projects
//
//  Created by Johnathan Stansbury on 10/12/12.
//  Copyright (c) 2012 LSU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>

#import "Shader.h"
#import "Mesh.h"

@interface Project1GLKitViewController : GLKViewController
{
    Shader *shade;
    Mesh   *mesh;
        
    float rotx;
    float roty;
    
    float rotx0;
    float roty0;
    
    GLKMatrix4 MVP;
    GLKMatrix3 N;
    GLKMatrix3 brick_color;
    GLKMatrix3 mortar_color;
    GLKMatrix2 brick_size;
    GLKMatrix2 brick_frac;
    
    GLuint uni_MVP;
    GLuint uni_N;
    GLuint uni_brick_color;
    GLuint uni_mortar_color;
    GLuint uni_brick_size;
    GLuint uni_brick_frac;
    
    CGPoint start;
}

@property (nonatomic, strong) NSString *meshName;



@end
