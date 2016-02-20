//
//  DCAnimationCards.m
//  DCCardsAnimation
//
//  Created by dawnnnnn on 16/1/25.
//  Copyright © 2016年 dawnnnnn. All rights reserved.
//

#import "DCAnimationCards.h"

/**< 窗口宽度 */
#define SCREEN_WIDTH [[UIScreen mainScreen]bounds].size.width
/**< 窗口高度 */
#define SCREEN_HEIGHT [[UIScreen mainScreen]bounds].size.height

@interface DCAnimationCards ()
{
    NSArray *_cardArr;
    CGPoint _tmpPoint;
    NSInteger _currentIndex;
}

@property (nonatomic, strong) UIView *bgView;

@end

@implementation DCAnimationCards

- (id)initWithCards:(NSArray*)cards {
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.3f];
        _cardArr = [[NSArray alloc]initWithArray:cards];
        [self drawView];
    }
    return self;
}

- (void)drawView {
    _bgView = [[UIView alloc]initWithFrame:self.frame];
    [self addSubview:_bgView];
    
    [self drawCardsZone];

    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panHandle:)];
    [_bgView addGestureRecognizer:pan];
}

- (void)show {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    
    self.backgroundColor = [UIColor clearColor];
    _bgView.transform = CGAffineTransformMakeScale(0.5f, 0.5f);

    [UIView animateWithDuration:.3f animations:^{
        _bgView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.5f];
    }];
}

- (void)drawCardsZone {
    for (int i = ((int)_cardArr.count-1); i >= 0; i --) {
        int j;
        UIImageView *cardView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 25, SCREEN_WIDTH-40, SCREEN_HEIGHT-80)];
        cardView.tag = 100+i;
        cardView.layer.cornerRadius = 4.f;
        cardView.layer.masksToBounds = YES;
        j = MIN(i, 2);
        cardView.transform = CGAffineTransformMakeScale(1-0.05*j, 1-0.05*j);
        cardView.transform = CGAffineTransformTranslate(cardView.transform, 0, j*15*2);
        cardView.backgroundColor = _cardArr[i];
//        cardView.image = _cardArr[i];
        _tmpPoint = cardView.center;
        [_bgView addSubview:cardView];
        
        UIView *whiteView = [[UIView alloc]initWithFrame:cardView.bounds];
        whiteView.tag = 201;
        whiteView.backgroundColor = [UIColor whiteColor];
        whiteView.alpha = i == 0 ? 0:.7;
        [cardView addSubview:whiteView];
    }
    _currentIndex = 0;
}

//手势拖拽
-(void)panHandle:(UIPanGestureRecognizer *)pan {
    if (pan.state == UIGestureRecognizerStateBegan) {
        NSLog(@"start");
    }
    else if (pan.state == UIGestureRecognizerStateChanged) {
        CGPoint offset = [pan translationInView:_bgView];
        UIView *dragObj = [_bgView viewWithTag:100+_currentIndex];
        [dragObj setCenter:CGPointMake(dragObj.center.x + offset.x, dragObj.center.y + offset.y)];
        [pan setTranslation:CGPointMake(0, 0) inView:_bgView];
    }
    else if (pan.state == UIGestureRecognizerStateEnded) {
        CGPoint last = [pan velocityInView:_bgView];
        UIView *dragObj = [_bgView viewWithTag:100+_currentIndex];
        if (last.x > 1500 || last.x < -1500) {
            [UIView animateWithDuration:.3 animations:^{
                dragObj.center = CGPointMake(last.x, _tmpPoint.y);
                dragObj.alpha = 0;
//                NSLog(@"%d _____",(int)_currentIndex);
                _currentIndex++;
                [self reloadCardsView];
            } completion:^(BOOL finished) {
                [dragObj removeFromSuperview];
            }];
        }
        else {
            [UIView animateWithDuration:.4 delay:0 usingSpringWithDamping:.7 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                dragObj.center = _tmpPoint;
            } completion:nil];
        }
    }
}

- (void)reloadCardsView {
    NSLog(@"%d _____",(int)_currentIndex);
    if (_currentIndex == _cardArr.count) {
        [UIView animateWithDuration:0.3f animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
    for (int i = 0; i < 3; i++) {
        UIView *cardView = [_bgView viewWithTag:100+_currentIndex+i];
        if (cardView) {
            UIView *whiteView = [cardView viewWithTag:201];
            [UIView animateWithDuration:.3 animations:^{
                cardView.transform = CGAffineTransformMakeScale(1-0.05*i, 1-0.05*i);
                cardView.transform = CGAffineTransformTranslate(cardView.transform, 0, i*15*2);
                whiteView.alpha = i == 0? 0:.7;
            }];
        }
    }
}


@end
