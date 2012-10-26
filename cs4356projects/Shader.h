//
//  Shader.h
//  cs4356projects
//
//  Created by Johnathan Stansbury on 10/26/12.
//  Copyright (c) 2012 LSU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Shader : NSObject
{
    GLuint program;
    GLuint vertShader;
    GLuint fragShader;
}

- (GLuint) uniform:(NSString *) name;

- (id)   initWithVert:(NSString *) vert
                 frag:(NSString *) frag;

- (void) dealloc;
- (void) use;

- (GLuint) compile:(GLenum) type file:(NSString *) file;
- (GLuint) link:   (GLuint) vert with:(GLuint) frag;

- (void) logShader:  (GLuint) shader;
- (void) logProgram: (GLuint) program;


@end
