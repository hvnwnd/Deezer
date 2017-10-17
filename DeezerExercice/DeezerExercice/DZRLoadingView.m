//
//  DZRLoadingView.m
//  DeezerExercice
//
//  Created by CHEN Bin on 17/10/2017.
//  Copyright © 2017 Deezer. All rights reserved.
//

#import "DZRLoadingView.h"


@interface DZRLoadingView()
@property (nonatomic) IBOutlet UIView *rootView;

@end

@implementation DZRLoadingView

- (void)loadNib{
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
}

-(void)commonInit
{
    [self loadNib];
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor clearColor];
    self.frame = self.rootView.frame;
    [self addSubview:self.rootView];

}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self commonInit];
    }
    return self;
}

-(id)initWithCoder:(NSCoder*)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self commonInit];
    }
    return self;
}


@end
