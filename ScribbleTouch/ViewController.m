//
//  ViewController.m
//  ScribbleTouch
//
//  Created by Richard Tyran on 1/14/15.
//  Copyright (c) 2015 Richard Tyran. All rights reserved.
//

#import "ViewController.h"
#import "ScribbleView.h"


@interface ViewController ()

@end

@implementation ViewController

{
    NSMutableDictionary * currentScribble;
    UIColor * selectedColor;
    UIColor * fillColor;
    int selectedStrokeWidth;
    int selectedOpacity;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    selectedColor = [UIColor blackColor];
    fillColor = [UIColor clearColor];
    selectedStrokeWidth = 1;
    selectedOpacity = 0.0;
    
}

- (IBAction)changeColor:(UIButton *)sender {
    
    selectedColor = sender.backgroundColor;
}

- (IBAction)changeStrokeWidth:(UISlider *)sender {
    
    selectedStrokeWidth = sender.value;
}

- (IBAction)changeFillColor:(UIButton *)sender {
    
    fillColor = sender.backgroundColor;
}

- (IBAction)changeOpacity:(UISlider *)sender {
    
    selectedOpacity = sender.value;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch * touch = touches.allObjects.firstObject;
    
    CGPoint location = [touch locationInView:self.view];
    
    
    currentScribble = [@{
                         
                         @"type":@"path",
                         @"fillColor":fillColor,
                         @"strokeColor":selectedColor,
                         @"strokeWidth":@(selectedStrokeWidth),
                         @"opacityLevel": @(selectedOpacity),
                         @"points":[@[[NSValue valueWithCGPoint:location]] mutableCopy]
                         
                         } mutableCopy];
    
    ScribbleView * sView = (ScribbleView *)self.view;
    
    [sView.scribbles addObject:currentScribble];
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch * touch = touches.allObjects.firstObject;
    
    CGPoint location = [touch locationInView:self.view];
    
    [currentScribble[@"points"] addObject:[NSValue valueWithCGPoint:location]];
    
    [self.view setNeedsDisplay];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
