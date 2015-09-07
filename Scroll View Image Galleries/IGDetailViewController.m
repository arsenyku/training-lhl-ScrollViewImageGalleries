//
//  IGDetailViewController.m
//  Scroll View Image Galleries
//
//  Created by asu on 2015-09-07.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import "IGDetailViewController.h"

@interface IGDetailViewController ()
@property (strong, nonatomic) IBOutlet UIScrollView *detailScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *detailImageView;

@end

@implementation IGDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.detailScrollView.minimumZoomScale = 1.0;
    self.detailScrollView.maximumZoomScale = 4.0;
    
    self.detailScrollView.delegate = self;
    
    self.detailImageView.image = self.image;

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

#pragma mark - <UIScrollViewDelegate>


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.detailImageView;
}

@end
