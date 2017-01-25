//
//  DCAnimationCards.m
//  DNCardViewDemo
//
//  Created by dawnnnnn on 16/1/25.
//  Copyright © 2016年 dawnnnnn. All rights reserved.
//

#import "DNCardView.h"

#define SCREEN_WIDTH [[UIScreen mainScreen]bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen]bounds].size.height

static CGFloat const kCommonPaddingLR       = 20.f;
static CGFloat const kCommonPaddingTop      = 25.f;
static CGFloat const kCardTranslatePaddingLR = 15.f;

@interface DNCardView ()

@property (nonatomic, strong) UIView *bgView;

@end

@interface DNCardView ()

@property (nonatomic, strong) NSArray *cardArray;

@property (nonatomic, assign) CGPoint point;
@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation DNCardView

#pragma mark - public methods

- (id)initWithCards:(NSArray*)cards {
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.3f];
        
        self.cardArray = [[NSArray alloc]initWithArray:cards];
        
        [self viewAddSubviews];
    }
    return self;
}

- (void)show {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    
    self.backgroundColor = [UIColor clearColor];
    self.bgView.transform = CGAffineTransformMakeScale(0.5f, 0.5f);
    
    [UIView animateWithDuration:.3f animations:^{
        self.bgView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.5f];
    }];
}


#pragma mark - private methods

- (void)viewAddSubviews {
    [self addSubview:self.bgView];
    
    [self viewAddCards];

    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panHandle:)];
    [self.bgView addGestureRecognizer:pan];
}

- (void)viewAddCards {
    for (int i = ((int)self.cardArray.count-1); i >= 0; i --) {
        int j;
        UIImageView *cardView = [[UIImageView alloc]initWithFrame:CGRectMake(kCommonPaddingLR, kCommonPaddingTop, SCREEN_WIDTH - kCommonPaddingLR * 2, SCREEN_HEIGHT - 80)];
        cardView.tag = 100+i;
        cardView.layer.cornerRadius = 4.f;
        cardView.layer.masksToBounds = YES;
        j = MIN(i, 2);
        cardView.transform = CGAffineTransformMakeScale(1 - 0.05 * j, 1 - 0.05 * j);
        cardView.transform = CGAffineTransformTranslate(cardView.transform, 0, j * kCardTranslatePaddingLR * 2);
        if ([self.cardArray[i] isKindOfClass:[UIImage class]]) {
            cardView.image = self.cardArray[i];
        } else if ([self.cardArray[i] isKindOfClass:[UIColor class]]) {
            cardView.backgroundColor = self.cardArray[i];
        }
        self.point = cardView.center;
        [self.bgView addSubview:cardView];
        
        UIView *whiteView = [[UIView alloc]initWithFrame:cardView.bounds];
        whiteView.tag = 201;
        whiteView.backgroundColor = [UIColor whiteColor];
        whiteView.alpha = i == 0 ? 0 : 0.7;
        [cardView addSubview:whiteView];
    }
    self.currentIndex = 0;
}

//手势拖拽
-(void)panHandle:(UIPanGestureRecognizer *)pan {
    if (pan.state == UIGestureRecognizerStateChanged) {
        CGPoint offset = [pan translationInView:self.bgView];
        UIView *dragObj = [self.bgView viewWithTag:100 + self.currentIndex];
        [dragObj setCenter:CGPointMake(dragObj.center.x + offset.x, dragObj.center.y + offset.y)];
        [pan setTranslation:CGPointMake(0, 0) inView:self.bgView];
    } else if (pan.state == UIGestureRecognizerStateEnded) {
        CGPoint last = [pan velocityInView:self.bgView];
        UIView *dragObj = [self.bgView viewWithTag:100 + self.currentIndex];
        if (last.x > 1500 || last.x < -1500) {
            [UIView animateWithDuration:.3 animations:^{
                dragObj.center = CGPointMake(last.x, self.point.y);
                dragObj.alpha = 0;
                self.currentIndex++;
                [self reloadCardsView];
            } completion:^(BOOL finished) {
                [dragObj removeFromSuperview];
            }];
        } else {
            [UIView animateWithDuration:.4 delay:0 usingSpringWithDamping:.7 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                dragObj.center = self.point;
            } completion:nil];
        }
    }
}

- (void)reloadCardsView {
    if (self.currentIndex == self.cardArray.count) {
        [UIView animateWithDuration:0.3f animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
    for (int i = 0; i < 3; i++) {
        UIView *cardView = [self.bgView viewWithTag:100 + self.currentIndex + i];
        if (cardView) {
            UIView *whiteView = [cardView viewWithTag:201];
            [UIView animateWithDuration:.3 animations:^{
                cardView.transform = CGAffineTransformMakeScale(1 - 0.05 * i, 1 - 0.05 * i);
                cardView.transform = CGAffineTransformTranslate(cardView.transform, 0, i * kCardTranslatePaddingLR * 2);
                whiteView.alpha = i == 0 ? 0 : 0.7;
            }];
        }
    }
}

#pragma mark - getter

- (UIView *)bgView {
    if (_bgView == nil) {
        _bgView = [[UIView alloc]initWithFrame:self.frame];
    }
    return _bgView;
}

@end
