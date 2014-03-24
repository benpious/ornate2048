//
//  CSSEnvironmentView.m
//  CodeSample
//
//  Created by Benjamin Pious on 3/23/14.
//  Copyright (c) 2014 benpious. All rights reserved.
//

#import "CSSEnvironmentView.h"
#import "CSSAsset.h"

@interface CSSEnvironmentView()
{
    GLuint viewFrameBuffer;
    GLuint colorRenderBuffer;
    GLuint depthRenderBuffer;
    GLint width;
    GLint height;
}


@end

@implementation CSSEnvironmentView
-(id) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame: frame]) {
        
        //set up background asset
        
        //set up texture render target for drawing asset into
        
        //set up render target for blurred texture
        
        //set up actual render target
        
        CAEAGLLayer* myEAGLLayer = (CAEAGLLayer*)self.layer;
        [myEAGLLayer setOpaque: YES];
        
        // Generate IDs for a framebuffer object and a color renderbuffer
        glGenFramebuffers(1, &viewFrameBuffer);
        glBindFramebuffer(GL_FRAMEBUFFER, viewFrameBuffer);
        
        glGenRenderbuffers(1, &colorRenderBuffer);
        glBindRenderbuffer(GL_RENDERBUFFER, colorRenderBuffer);
        
        [self.glESContext renderbufferStorage: GL_RENDERBUFFER fromDrawable: myEAGLLayer];
        
        glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, colorRenderBuffer);
        
        glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_WIDTH, &width);
        glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_HEIGHT, &height);
        
        //generate and attach the depth buffer
        glGenRenderbuffers(1, &depthRenderBuffer);
        glBindRenderbuffer(GL_RENDERBUFFER, depthRenderBuffer);
        glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT16, width, height);
        glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, depthRenderBuffer);
        GLenum status = glCheckFramebufferStatus(GL_FRAMEBUFFER);
        
        if(status != GL_FRAMEBUFFER_COMPLETE) {
            
            NSLog(@"failed to make complete framebuffer object %x", status);
        }
        
        glEnable(GL_DEPTH_TEST);
        glViewport(0.0, 0.0, width, height);
        glClearColor(0.0, 0.75f, 0.75f, 1.0f);
    }
    
    return self;
}

-(void) drawFrame:(CADisplayLink *)displayLink
{
    
    [EAGLContext setCurrentContext: self.glESContext];
    [super drawFrame: displayLink];
    //draw background asset to texture
    
    //blur background asset and set up texture access
    
    //draw background texture
    
    //draw tile textures
    
    const GLenum discards[1] = {GL_DEPTH_ATTACHMENT};
    
    glBindFramebuffer(GL_FRAMEBUFFER, viewFrameBuffer);
    
    glBindRenderbuffer(GL_RENDERBUFFER, colorRenderBuffer);
    
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    for (CSSAsset* currAsset in self.assets) {
        
        [currAsset prepareToDraw];
        [currAsset draw];
    }
    
    glDiscardFramebufferEXT(GL_FRAMEBUFFER, 1, discards);
    
    [self.glESContext presentRenderbuffer: GL_RENDERBUFFER];
}

@end
