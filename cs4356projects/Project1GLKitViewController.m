//
//  Project1GLKitViewController.m
//  cs4356projects
//
//  Created by Johnathan Stansbury on 10/12/12.
//  Copyright (c) 2012 LSU. All rights reserved.
//

#import "Project1GLKitViewController.h"

@interface Project1GLKitViewController ()
{
    float _curRed;
    BOOL _increasing;
    
}

@property (strong, nonatomic) EAGLContext *context;

- (void) initGL;

@end

@implementation Project1GLKitViewController
@synthesize context = _context;
@synthesize meshName = _meshName;
@synthesize vertShaderName = _vertShaderName;
@synthesize shaderName = _shaderName;
@synthesize fragShaderName = _fragShaderName;

/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    if (!self.context) {
        NSLog(@"Failed to create ES context");
    }
    
    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    
    [self initGL];
        
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initGL
{
    [EAGLContext setCurrentContext:self.context];
    
    NSString *vertPathname = [[NSBundle mainBundle] pathForResource:self.vertShaderName ofType:@"glsl"];
    NSString *fragPathname = [[NSBundle mainBundle] pathForResource:self.fragShaderName ofType:@"glsl"];
    NSString *meshPathname = [[NSBundle mainBundle] pathForResource:self.meshName  ofType:@"dat"];
    NSLog(@"%@", self.meshName);
    
    // Initialize the shader.
    
    shade = [[Shader alloc] initWithVert:vertPathname
                                    frag:fragPathname];
    
    uni_MVP = [shade uniform:@"modelViewProjectionMatrix"];
    uni_N   = [shade uniform:@"normalMatrix"];
    uni_brick_color = [shade uniform:@"brick_color"];
    uni_mortar_color = [shade uniform:@"mortar_color"];
    uni_brick_size = [shade uniform:@"brick_size"];
    uni_brick_frac = [shade uniform:@"brick_frac"];
    
    
    // Initialize the model.
    
    mesh = [[Mesh alloc] initWithFile:meshPathname];
    
    // Set other global GL state.
    
    glEnable(GL_DEPTH_TEST);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShaderViewSegue"]) {
        ShaderViewController *shaderVC = segue.destinationViewController;
        shaderVC.delegate = self;
        
    }
}

-(void)shaderViewController:(ShaderViewController *)shaderVC didSaveOption:(NSString *)newShader
{
    self.shaderName = newShader;
    self.vertShaderName = [self.shaderName stringByAppendingString:@"Vertex"];
    self.fragShaderName = [self.shaderName stringByAppendingString:@"Fragment"];
    [self initGL];
}


#pragma mark - GLKViewDelegate



- (void) glkView:(GLKView *) view drawInRect:(CGRect) rect
{
    glClearColor(0.65f, 0.65f, 0.65f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    [shade use];
    
    glUniformMatrix4fv(uni_MVP, 1, 0, MVP.m);
    glUniformMatrix3fv(uni_N,   1, 0, N.m);
    glUniform3f(uni_brick_color, 1.0f, 0.0f, 0.0f);
    glUniform3f(uni_mortar_color, 0.46f, 0.53f, 0.59f);
    glUniform2f(uni_brick_size, 0.25f, 0.25f);
    glUniform2f(uni_brick_frac, 0.9f, 0.9f);
    
    [mesh draw];
}

#pragma mark - GLKViewControllerDelegate

- (void) update
{
    GLKMatrix4 P;
    GLKMatrix4 V;
    GLKMatrix4 M;
    GLKMatrix4 MV;
    
    // Perspective matrix.
    
    float fov    = GLKMathDegreesToRadians(45.0f);
    float aspect = fabsf(self.view.bounds.size.width
                         / self.view.bounds.size.height);
    
    P   = GLKMatrix4MakePerspective(fov, aspect, 0.1f, 100.0f);
    
    // View matrix.
    
    V   = GLKMatrix4MakeTranslation(0.0f, 0.0f, -2.0f);
    
    // Model matrix.
    
    M   = GLKMatrix4MakeRotation(rotx, 1.0f,  0.0f, 0.0f);
    M   = GLKMatrix4Rotate   (M, roty, 0.0f,  1.0f, 0.0f);
    M   = GLKMatrix4Translate(M,       0.0f, -0.5f, 0.0f);
    
    // MVP.
    
    MV  = GLKMatrix4Multiply(V, M);
    N   = GLKMatrix3InvertAndTranspose(GLKMatrix4GetMatrix3(MV), NULL);
    MVP = GLKMatrix4Multiply(P, MV);
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSUInteger touchCount = 0;
    for (UITouch *touch in touches)
    {
        touchCount++;
    }
    NSLog(@"%d", touchCount);
    UITouch *touch = [touches anyObject];
    start = [touch locationInView:self.view];
    rotx0 = rotx;
    roty0 = roty;
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    
    int dx = point.y - start.y;
    int dy = point.x - start.x;
    
    rotx = rotx0 + dx / 200.0;
    roty = roty0 + dy / 200.0;
}


@end
