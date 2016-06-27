//
//  ViewControllerInfo.m
//  AutomotiveHeadlines
//
//  Created by liuyanqi on 16/6/27.
//  Copyright © 2016年 liuyanqi. All rights reserved.
//

#import "ViewControllerInfo.h"
#import "UIColor+Hex.h"
@interface ViewControllerInfo ()<UIScrollViewDelegate>
{
    float kuanDuZhi;
    float widthButton;
    float XPianYi;
    UIView *_jiaoDianTiao;
    UIScrollView *_scrollViewNav ;
    UIScrollView *_scrollViewContent;
    UIView *_viewTint;
    NSMutableArray *_arrayNavName;
}
@end

@implementation ViewControllerInfo

- (void)viewDidLoad {
    [super viewDidLoad];
    [self jieMianBuJu];

}
//布局界面
-(void)jieMianBuJu
{
    //导航条ScrollView
    _scrollViewNav = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 24, self.view.frame.size.width - 60, 40)];
    [self.view addSubview:_scrollViewNav];
    //在scrolView上设置按钮
    _arrayNavName=[[NSMutableArray alloc]initWithObjects:@"头条",@"视频",@"新车",@"行业",@"导购",@"头条客",@"用车", nil];
    for (int i = 0; i < _arrayNavName.count; i ++) {
        NSString *nameStr = [_arrayNavName objectAtIndex:i ];
        float length = [nameStr length];
        widthButton = length * 30;
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(XPianYi, 0, widthButton, 40)];
        [button setTitle:[_arrayNavName objectAtIndex:i ] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        button.tag = i+100;
        [button addTarget:self action:@selector(navButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor colorWithHexString:@"#525252"] forState:UIControlStateNormal];
        
        XPianYi = XPianYi + widthButton;
        [_scrollViewNav addSubview:button];
    }
    _scrollViewNav.contentSize = CGSizeMake(XPianYi, 40);
    _scrollViewNav.showsHorizontalScrollIndicator = NO;
    
    //"添加按钮"
    UIButton *buttonAdd = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-40, 29, 23, 23)];
    [self.view addSubview:buttonAdd];
    [buttonAdd setBackgroundImage:[UIImage imageNamed:@"newHometianjia"] forState:UIControlStateNormal];
    [buttonAdd addTarget:self action:@selector(addNavClick) forControlEvents:(UIControlEventTouchUpInside)];
    //指示条
    _viewTint = [[UIView alloc]init];
    UIButton *button =(UIButton *) [_scrollViewNav viewWithTag:100];
    _viewTint.frame = CGRectMake(0, 38, CGRectGetWidth(button.frame), 2);

    _viewTint.backgroundColor = [UIColor colorWithHexString:@"#17abc1"];
    [_scrollViewNav addSubview:_viewTint];
    
//    ContentscrollView   显示内容
    _scrollViewContent = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.height, self.view.frame.size.height - 64 - 49)];
    
    [self.view addSubview:_scrollViewContent];
    _scrollViewContent.contentSize = CGSizeMake(self.view.frame.size.width * _arrayNavName.count, self.view.frame.size.height);
    _scrollViewContent.backgroundColor = [UIColor orangeColor];
    _scrollViewContent.pagingEnabled = YES;
    
    _scrollViewContent.delegate = self;
    _scrollViewContent.showsHorizontalScrollIndicator = NO;
    
    
    
}
//导航条上的按钮点击事件
-(void)navButtonClick:(UIButton *)sender
{
    
    //遍历所有按钮  把颜色 大小重置
    for (int i = 0; i < _arrayNavName.count ; i ++) {
        UIButton *button = [_scrollViewNav viewWithTag:i + 100];
        
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        [button setTitleColor:[UIColor colorWithHexString:@"#525252"] forState:UIControlStateNormal];
        
    }
    //点击按钮  改变颜色大小  指示条
    NSLog(@"%ld",(long)sender.tag);
    [UIView animateWithDuration:0.1 animations:^{
        UIButton *button = [_scrollViewNav viewWithTag:sender.tag];
        button.titleLabel.font = [UIFont systemFontOfSize:18];
        [button setTitleColor:[UIColor colorWithHexString:@"#17abc1"] forState:UIControlStateNormal];
        _viewTint.frame = CGRectMake(button.frame.origin.x, 38, button.frame.size.width, 2);
        
    } completion:^(BOOL finished) {
        UIButton *button = [_scrollViewNav viewWithTag:sender.tag - 2];
        if (sender.tag - 100 == _arrayNavName.count - 1) {
            return ;
        }
        if (sender.tag - 100 > 2) {
            [_scrollViewNav setContentOffset:CGPointMake(button.frame.origin.x , 0) animated:YES];
        }
        if (sender.tag - 100 <=2) {
            [_scrollViewNav setContentOffset:CGPointMake(0 , 0) animated:YES];
        }
    }];
    
}
-(void)addNavClick
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
