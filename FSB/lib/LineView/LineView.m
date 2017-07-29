//
//  LineView.m
//  FSB
//
//  Created by 大家保 on 2017/7/29.
//  Copyright © 2017年 dajiabao. All rights reserved.
//

#import "LineView.h"

//视图的宽度
#define  selfWidth (self.frame.size.width)

//视图的高度
#define selfHeight (self.frame.size.height)

//y刻度视图所占宽度
#define leftViewWidth (60)

//x刻度视图所占的高度
#define bottomViewHeight (32)

//y刻度所占高度
#define leftViewHeight (selfHeight-bottomViewHeight)

//表格主视图所占宽度
#define tableWidth (selfWidth-leftViewWidth)

//x刻度视图所占的宽度
#define bottomViewWidth (tableWidth)

//表格主视图所占高度
#define tableHeight (selfHeight-bottomViewHeight)

//每一个小格子的宽度
#define xWidth (tableWidth/7.0)

//每一个小格的高度
#define yHeight  (leftViewHeight/7.0)

@interface LineView (){
    //线的颜色
    CAShapeLayer *shapeLayer;
    //填充域
    CAGradientLayer *gradientLayer;
    //基础域
    CALayer *baseLayer;
}

//按钮数组
@property (nonatomic,strong) NSMutableArray *btnArray;

//所有坐标点的数组
@property (nonatomic,strong) NSMutableArray *pointArray;

//x坐标label数组
@property (nonatomic,strong) NSMutableArray *xLabelArray;

//y坐标label数组
@property (nonatomic,strong) NSMutableArray *yLabelArray;

//所有的横线数组
@property (nonatomic,strong) NSMutableArray *horiLineArray;

//所有的竖线数组
@property (nonatomic,strong) NSMutableArray *vertiLineArray;

//表格视图
@property (nonatomic,strong) UIView *tableView;

@end

@implementation LineView

//初始化
- (instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        //线条颜色
        self.xlineColor=[UIColor darkGrayColor];
        self.ylineColor=[UIColor darkGrayColor];
        //文字颜色
        self.xtitleColor=[UIColor darkGrayColor];
        self.ytitleColor=[UIColor darkGrayColor];
        //表格的背景颜色
        self.tableViewBgColor=[UIColor clearColor];
        //背景颜色
        self.backgroundColor=[UIColor whiteColor];
        //按钮和线的颜色
        self.btnColor=[UIColor redColor];
        self.btnLineColor=[UIColor redColor];
        //每一个格子的高度
        //添加线条
        [self addLines];
        //添加y刻度视图
        [self addleftView];
        //添加x刻度视图
        [self addBottomView];
        
    }
    return self;
}

//添加线条
- (void)addLines{
    //添加表格视图
    self.tableView=[[UIView alloc]initWithFrame:CGRectMake(leftViewWidth, 0,tableWidth , tableHeight)];
    self.tableView.backgroundColor=self.tableViewBgColor;
    //添加横线
    for (int i=1; i<=7; i++) {
        UILabel *horiLine=[[UILabel alloc]initWithFrame:CGRectMake(0,i*yHeight, tableWidth-xWidth, 0.5)];
        horiLine.backgroundColor=self.xlineColor;
        [self.tableView addSubview:horiLine];
        [self.horiLineArray addObject:horiLine];
    }
    //添加竖线
    for (int i=1; i<=7; i++) {
        UILabel *verticalLine=[[UILabel alloc]initWithFrame:CGRectMake(i*xWidth,yHeight, 0.5, tableHeight-yHeight)];
        verticalLine.backgroundColor=self.ylineColor;
        [self.tableView addSubview:verticalLine];
        [self.vertiLineArray addObject:verticalLine];

    }
    [self addSubview:self.tableView];
}

//添加y刻度视图
- (void)addleftView{
    UIView *leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, leftViewWidth, leftViewHeight)];
    leftView.backgroundColor=[UIColor clearColor];
    for (int i=1; i<=7; i++) {
        UILabel *leftLine=[[UILabel alloc]initWithFrame:CGRectMake(0,i*yHeight-8, leftViewWidth-10, 16)];
        leftLine.textAlignment=NSTextAlignmentRight;
        leftLine.font=[UIFont systemFontOfSize:12];
        leftLine.textColor=self.ytitleColor;
        [leftView addSubview:leftLine];
        [self.yLabelArray addObject:leftLine];
    }
    [self addSubview:leftView];
}

//添加x刻度视图
- (void)addBottomView{
    UIView *bottomView=[[UIView alloc]initWithFrame:CGRectMake(leftViewWidth-xWidth, leftViewHeight, bottomViewWidth+xWidth, bottomViewHeight)];
    bottomView.backgroundColor=[UIColor clearColor];
    for (int i=1; i<=7; i++) {
        UILabel *bottomLine=[[UILabel alloc]initWithFrame:CGRectMake(i*xWidth-xWidth/2.0,10, xWidth,12)];
        bottomLine.textAlignment=NSTextAlignmentCenter;
        bottomLine.font=[UIFont systemFontOfSize:12];
        bottomLine.textColor=self.xtitleColor;
        [bottomView addSubview:bottomLine];
        [self.xLabelArray addObject:bottomLine];
    }
    [self addSubview:bottomView];
}

//设置数据源
- (void)setDataArr:(NSArray *)dataArr{
    //添加点和按钮
    [self addDataPointWithArr:dataArr];
    //添加连线
    [self addLineBezierPoint:self.tableView];
}


//添加点和按钮
-(void)addDataPointWithArr:(NSArray *)dataArr{
    [self.btnArray removeAllObjects];
    [self.pointArray removeAllObjects];
    //表格的6/7高度
    CGFloat calculateHeight=tableHeight*6/7.0;
    //初始点
    NSMutableArray *arr = [NSMutableArray arrayWithArray:dataArr];
    for (int i = 0; i<arr.count; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((xWidth)*i-3, [arr[i] floatValue]* calculateHeight-3+yHeight, 6, 6)];
        btn.backgroundColor = self.btnColor;
        btn.layer.borderColor = self.btnColor.CGColor;
        btn.layer.borderWidth = 1;
        btn.layer.cornerRadius = 3;
        btn.layer.masksToBounds = YES;
        //数组添加按钮
        [self.btnArray addObject:btn];
        //数组添加点
        NSValue *point = [NSValue valueWithCGPoint:btn.center];
        [self.pointArray addObject:point];
    }
}


//添加连线
- (void)addLineBezierPoint:(UIView *)view{
    //取得起始点
    CGPoint firstPoint = [[self.pointArray objectAtIndex:0] CGPointValue];
    //取得终点
    CGPoint lastPoint;
    //直线的连线
    UIBezierPath *beizer = [UIBezierPath bezierPath];
    [beizer moveToPoint:firstPoint];
    //遮罩层的形状
    UIBezierPath *bezier1 = [UIBezierPath bezierPath];
    bezier1.lineCapStyle = kCGLineCapRound;
    bezier1.lineJoinStyle = kCGLineJoinMiter;
    [bezier1 moveToPoint:firstPoint];
    //描绘路径
    for (int i = 0;i<self.pointArray.count;i++ ) {
        if (i != 0) {
            CGPoint point = [[self.pointArray objectAtIndex:i] CGPointValue];
            [beizer addLineToPoint:point];
            [bezier1 addLineToPoint:point];
            if (i == self.pointArray.count-1) {
                [beizer moveToPoint:point];//添加连线
                lastPoint = point;
            }
        }
    }
    //获取最后一个点的X值
    CGFloat lastPointX = lastPoint.x;
    //最后一个点对应的坐标
    CGPoint endPoint = CGPointMake(lastPointX, tableHeight);
    [bezier1 addLineToPoint:endPoint];
    //回到原点
    [bezier1 addLineToPoint:CGPointMake(firstPoint.x,tableHeight)];
    [bezier1 addLineToPoint:firstPoint];
    //遮罩层
    CAShapeLayer *shadeLayer = [CAShapeLayer layer];
    shadeLayer.path = bezier1.CGPath;
    shadeLayer.fillColor = [UIColor redColor].CGColor;
    [view.layer addSublayer:shadeLayer];
    
    //渐变图层
    gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, 0, tableHeight);
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    gradientLayer.cornerRadius =0;
    gradientLayer.masksToBounds = YES;
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:166/255.0 green:206/255.0 blue:247/255.0 alpha:0.7].CGColor,(__bridge id)[UIColor colorWithRed:237/255.0 green:246/255.0 blue:253/255.0 alpha:0.5].CGColor];
    gradientLayer.locations = @[@(0.5f)];
    
    [baseLayer removeFromSuperlayer];
    baseLayer = [CALayer layer];
    [baseLayer addSublayer:gradientLayer];
    [baseLayer setMask:shadeLayer];
    [view.layer addSublayer:baseLayer];
    
    CABasicAnimation *anmi1 = [CABasicAnimation animation];
    anmi1.keyPath = @"bounds";
    anmi1.duration = 1.5;
    anmi1.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 2*lastPoint.x, tableHeight)];
    anmi1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anmi1.fillMode = kCAFillModeForwards;
    anmi1.autoreverses = NO;
    anmi1.removedOnCompletion = NO;
    [gradientLayer addAnimation:anmi1 forKey:@"bounds"];
    
    
    //移除旧的连线
    [shapeLayer removeFromSuperlayer];
    //添加新的动画连线
    shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = beizer.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = self.btnLineColor.CGColor;
    shapeLayer.lineWidth = 1;
    [view.layer addSublayer:shapeLayer];
    
    
    CABasicAnimation *anmi = [CABasicAnimation animation];
    anmi.keyPath = @"strokeEnd";
    anmi.fromValue = [NSNumber numberWithFloat:0];
    anmi.toValue = [NSNumber numberWithFloat:1.0f];
    anmi.duration = 1.5;
    anmi.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anmi.autoreverses = NO;
    [shapeLayer addAnimation:anmi forKey:@"stroke"];
    
    //移除旧的按钮
    for (id btn in view.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            [btn removeFromSuperview];
        }
    }
    //添加新的按钮
    for (UIButton *btn in self.btnArray) {
        [view addSubview:btn];
    }
}

//设置底部的刻度
- (void)setXArray:(NSArray *)xArray{
    for (int i=0; i<self.xLabelArray.count; i++) {
        if (i<xArray.count) {
            UILabel *label=self.xLabelArray[i];
            label.text=xArray[i];
        }
    }
}

//设置左边的刻度
- (void)setYArray:(NSArray *)yArray{
    yArray=[[yArray reverseObjectEnumerator] allObjects];
    for (int i=0; i<self.yLabelArray.count; i++) {
        if (i<yArray.count) {
            UILabel *label=self.yLabelArray[i];
            label.text=yArray[i];
        }
    }
}

//设置xtitleColor
- (void)setXtitleColor:(UIColor *)xtitleColor{
    for (int i=0; i<self.xLabelArray.count; i++) {
        UILabel *label=self.xLabelArray[i];
        label.textColor=xtitleColor;
    }
 }

//设置ytitleColor
- (void)setYtitleColor:(UIColor *)ytitleColor{
    for (int i=0; i<self.yLabelArray.count; i++) {
        UILabel *label=self.yLabelArray[i];
        label.textColor=ytitleColor;
    }
}


//设置表格的背景颜色
- (void)setTableViewBgColor:(UIColor *)tableViewBgColor{
    self.tableView.backgroundColor=tableViewBgColor;
}

//设置表格横线颜色
- (void)setXlineColor:(UIColor *)xlineColor{
    for (int i=0; i<self.horiLineArray.count; i++) {
        UILabel *horiLine=self.horiLineArray[i];
        horiLine.backgroundColor=xlineColor;
    }
}

//设置表格竖线的颜色
- (void)setYlineColor:(UIColor *)ylineColor{
    for (int i=0; i<self.vertiLineArray.count; i++) {
        UILabel *verticalLine=self.vertiLineArray[i];
        verticalLine.backgroundColor=ylineColor;
    }
}

//设置按钮颜色
- (void)setBtnColor:(UIColor *)btnColor{
    for (int i=0; i<self.btnArray.count; i++) {
        UIButton *btn=self.btnArray[i];
        btn.backgroundColor=btnColor;
        btn.layer.borderColor =btnColor.CGColor;
    }
}

//设置连线颜色
- (void)setBtnLineColor:(UIColor *)btnLineColor{
     shapeLayer.strokeColor = btnLineColor.CGColor;
}

//设置填充颜色
- (void)setFillColorArray:(NSArray *)fillColorArray{
    gradientLayer.colors=fillColorArray;
}


#pragma mark数组懒加载
- (NSMutableArray *)btnArray{
    if (!_btnArray) {
        _btnArray=[NSMutableArray array];
    }
    return _btnArray;
}

- (NSMutableArray *)pointArray{
    if (!_pointArray) {
        _pointArray=[NSMutableArray array];
    }
    return _pointArray;
}

- (NSMutableArray *)xLabelArray{
    if (!_xLabelArray) {
        _xLabelArray=[NSMutableArray array];
    }
    return _xLabelArray;
}

- (NSMutableArray *)yLabelArray{
    if (!_yLabelArray) {
        _yLabelArray=[NSMutableArray array];
    }
    return _yLabelArray;
}

- (NSMutableArray *)horiLineArray{
    if (!_horiLineArray) {
        _horiLineArray=[NSMutableArray array];
    }
    return _horiLineArray;
}

- (NSMutableArray *)vertiLineArray{
    if (!_vertiLineArray) {
        _vertiLineArray=[NSMutableArray array];
    }
    return _vertiLineArray;
}

@end
