//
//  ViewController.m
//  Scroll View Image Galleries
//
//  Created by asu on 2015-09-07.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import "IGGalleryViewController.h"
#import "IGDetailViewController.h"

@interface IGGalleryViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *galleryScrollView;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapRecognizer;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end

@implementation IGGalleryViewController

#pragma mark - lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

    self.galleryScrollView.delegate = self;
    
    NSArray *images = @[ @"Lighthouse-in-Field", @"Lighthouse-night", @"Lighthouse-zoomed" ];
    
    UIImageView *previousImageView = nil;
    for (int i = 0 ; i < [images count] ; i++){
        UIImageView *imageView = [UIImageView new];
        imageView.image = [UIImage imageNamed:images[i]];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.userInteractionEnabled = YES;
        
        [self.galleryScrollView addSubview:imageView];
        [self layoutImageView:imageView rightOfView:previousImageView];
        previousImageView = imageView;
    }
    [self rightTerminatorConstraint:previousImageView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -  <UIScrollViewDelegate>

-(int)pageNumberFromOffset{
    return round(self.galleryScrollView.contentOffset.x / self.view.frame.size.width);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    self.pageControl.currentPage = [self pageNumberFromOffset];
    [self.galleryScrollView bringSubviewToFront:self.pageControl];

}

#pragma mark - events from controls

- (IBAction)tapDetected:(id)sender {
    NSLog(@"%@", sender);
    CGPoint tapLocation = [self.tapRecognizer locationInView:self.tapRecognizer.view];
    UIImageView* hitView = (UIImageView*)[self.galleryScrollView hitTest:tapLocation withEvent:nil];

    if ([hitView isKindOfClass:[UIImageView class]]){
        [self performSegueWithIdentifier:@"showDetail" sender:hitView.image];
        
    }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showDetail"]){
        ((IGDetailViewController*)segue.destinationViewController).image = sender;
        
    }
}

- (IBAction)pageControlPressed:(UIPageControl*)sender {
   
}


#pragma mark - private

-(void)layoutImageView:(UIImageView*)view rightOfView:(UIView*)previousView{
    view.translatesAutoresizingMaskIntoConstraints = NO;
    
    
	NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.galleryScrollView
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                           constant:0.0];
    NSLayoutConstraint *left;
    if (previousView == nil)
    {
        left = [NSLayoutConstraint constraintWithItem:view
                                            attribute:NSLayoutAttributeLeft
                                            relatedBy:NSLayoutRelationEqual
                                               toItem:self.galleryScrollView
                                            attribute:NSLayoutAttributeLeft
                                           multiplier:1.0
                                             constant:0.0];
    }else{
        left = [NSLayoutConstraint constraintWithItem:view
                                            attribute:NSLayoutAttributeLeft
                                            relatedBy:NSLayoutRelationEqual
                                               toItem:previousView
                                            attribute:NSLayoutAttributeRight
                                           multiplier:1.0
                                             constant:0.0];
    }
    
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:view
                                                             attribute:NSLayoutAttributeHeight
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.galleryScrollView
                                                             attribute:NSLayoutAttributeHeight
                                                            multiplier:1.0
                                                              constant:0.0];
    
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:view
                                                             attribute:NSLayoutAttributeWidth
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.galleryScrollView
                                                             attribute:NSLayoutAttributeWidth
                                                            multiplier:1.0
                                                              constant:0.0];
    
    [self.galleryScrollView addConstraints:@[ top, left, height, width ]];
    
}

-(void)rightTerminatorConstraint:(UIImageView*)view{
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:view
                                                             attribute:NSLayoutAttributeRight
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.galleryScrollView
                                                             attribute:NSLayoutAttributeRight
                                                            multiplier:1.0
                                                              constant:0.0];
    
    [self.galleryScrollView addConstraint:right];
}

@end

















