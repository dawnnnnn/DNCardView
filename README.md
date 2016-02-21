# DCCardAnimation
仿AppSolution内查看app预览图时的效果


# Preview 预览
![screenshots](https://raw.githubusercontent.com/dawnnnnn/DCCardAnimation/master/screenshots/DCCardAnimation.gif)


# Usage 使用

``` objc
	NSArray *cardArr = @[[UIColor redColor], [UIColor blueColor], [UIColor yellowColor], [UIColor greenColor], [UIColor grayColor]];
    DCAnimationCards *cards = [[DCAnimationCards alloc]initWithCards:cardArr];
    [self.view addSubview:cards];
```
cardArr为存放背景或image的数组。

### 补充说明
	普通拖拽卡会会弹回原位置，加速情况才会至下一张，该效果可在源码中修改
    
    
# License  
MIT

