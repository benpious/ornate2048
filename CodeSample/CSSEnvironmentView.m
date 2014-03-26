//
//  CSSEnvironmentView.m
//  CodeSample
//
//  Created by Benjamin Pious on 3/23/14.
//  Copyright (c) 2014 benpious. All rights reserved.
//

#import "CSSEnvironmentView.h"
#import "CSSAsset.h"
#import "CSSEnvironmentVariables.h"

@interface CSSEnvironmentView()
{
    GLuint viewFrameBuffer;
    GLuint colorRenderBuffer;
    GLuint depthRenderBuffer;
    GLint width;
    GLint height;
    
    GLuint blurFrameBuffer;
    GLuint blurRenderBuffer;
    GLuint blurTexture;
}

@end

@implementation CSSEnvironmentView
-(id) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame: frame]) {
        
        GLenum status;
        
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
        status = glCheckFramebufferStatus(GL_FRAMEBUFFER);
        
        if(status != GL_FRAMEBUFFER_COMPLETE) {
            
            NSLog(@"failed to make complete framebuffer object %x", status);
        }

        //set up background asset
        
        //set up texture render target for drawing asset into
        // Generate IDs for a framebuffer object and a color renderbuffer
        
        glGenFramebuffers(1, &blurFrameBuffer);
        glBindFramebuffer(GL_FRAMEBUFFER, blurFrameBuffer);
        
        GLuint depthRenderbuffer;
        glGenRenderbuffers(1, &depthRenderbuffer);
        glBindRenderbuffer(GL_RENDERBUFFER, depthRenderbuffer);
        glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT16, width, height);
        glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, depthRenderbuffer);

        glGenTextures(1, &blurTexture);
        glBindTexture(GL_TEXTURE_2D, blurTexture);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
        
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
        
        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, NULL);
        glFramebufferTexture2D(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_TEXTURE_2D, blurTexture, 0);
        
        status = glCheckFramebufferStatus(GL_FRAMEBUFFER);
        
        if(status != GL_FRAMEBUFFER_COMPLETE) {
            
            NSLog(@"failed to make complete framebuffer object %x", status);
        }
        
        glEnable(GL_BLEND);
        glBlendFunc (GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
        glEnable(GL_DEPTH_TEST);
        glViewport(0.0, 0.0, width, height);
        glClearColor(0.5f, 0.75f, 0.75f, 1.0f);
        
        self.environmentVars = [[CSSEnvironmentVariables alloc] init];
        self.environmentVars.transformationMatrix = GLKMatrix4MakeLookAt(0.0, 0.0, 2.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0);
        self.environmentVars.projectionMatrix = GLKMatrix4MakePerspective(0.610865238, 1024/768, 0.01, 100);
    }
    
    return self;
}

-(void) makeBlurTextureCurrentTexture
{
    
}

-(void) drawBackground
{
    
    [EAGLContext setCurrentContext: self.glESContext];
    //draw background asset to texture
    
    glBindFramebuffer(GL_FRAMEBUFFER, blurFrameBuffer);
    
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    [self.backgroundAsset prepareToDraw];
    [self.backgroundAsset draw];
}

-(void) prepareToDrawMainView
{
    
    glBindFramebuffer(GL_FRAMEBUFFER, viewFrameBuffer);
    
    glBindRenderbuffer(GL_RENDERBUFFER, colorRenderBuffer);

    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    [self.backgroundAsset prepareToDraw];
    [self.backgroundAsset draw];
    
    //to prevent the background from covering up foreground stuff
    glClear(GL_DEPTH_BUFFER_BIT);
}

-(void) drawToMainView
{
    
    const GLenum discards[1] = {GL_DEPTH_ATTACHMENT};
    
    glDiscardFramebufferEXT(GL_FRAMEBUFFER, 1, discards);
    
    [self.glESContext presentRenderbuffer: GL_RENDERBUFFER];
}

-(GLuint) blurViewTextureName
{
    
    return blurTexture;
}

@end
