//
//  ViewController.m
//  FSB
//
//  Created by 大家保 on 2017/7/29.
//  Copyright © 2017年 dajiabao. All rights reserved.
//

#import "ViewController.h"
#import "LineView.h"

@interface ViewController (){
    LineView *lineView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    lineView=[[LineView alloc]initWithFrame:CGRectMake(0, 30, [UIScreen mainScreen].bounds.size.width, 300)];
    [self.view addSubview:lineView];
    
    
    lineView.dataArr =[self caluleteMultiple:@[@"6000",@"3000",@"1000",@"4000",@"1000",@"6000",@"0"] yArray:@[@"0",@"1000",@"2000",@"3000",@"4000",@"5000",@"6000"]];
    lineView.xArray=@[@"1号",@"2号",@"3号",@"4号",@"5号",@"6号",@"7号"];
    lineView.yArray=@[@"0",@"1000",@"2000",@"3000",@"4000",@"5000",@"6000"];
    lineView.xtitleColor=[UIColor darkGrayColor];
    lineView.ytitleColor=[UIColor darkGrayColor];
    lineView.xlineColor=[UIColor lightGrayColor];
    lineView.ylineColor=[UIColor clearColor];
    lineView.tableViewBgColor=[UIColor clearColor];
    lineView.btnColor=[UIColor redColor];
    lineView.btnLineColor=[UIColor redColor];
    lineView.fillColorArray= @[(__bridge id)[[UIColor redColor]colorWithAlphaComponent:0.2].CGColor,(__bridge id)[[UIColor greenColor]colorWithAlphaComponent:0.5].CGColor];
    
    
    UIButton *dayButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 350, 50, 35)];
    [dayButton setTitle:@"日" forState:0];
    [dayButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [dayButton setTitleColor:[UIColor blackColor] forState:0];
    [dayButton setBackgroundColor:[UIColor yellowColor]];
    dayButton.tag=100;
    [dayButton addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dayButton];
    
    UIButton *monthButton=[[UIButton alloc]initWithFrame:CGRectMake(50, 350, 50, 35)];
    [monthButton setTitle:@"月" forState:0];
    [monthButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [monthButton setTitleColor:[UIColor blackColor] forState:0];
    [monthButton setBackgroundColor:[UIColor yellowColor]];
    monthButton.tag=101;
    [monthButton addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:monthButton];
    
    UIButton *halfYear=[[UIButton alloc]initWithFrame:CGRectMake(100, 350, 50, 35)];
    [halfYear setTitle:@"半年" forState:0];
    [halfYear.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [halfYear setTitleColor:[UIColor blackColor] forState:0];
    [halfYear setBackgroundColor:[UIColor yellowColor]];
    halfYear.tag=102;
    [halfYear addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:halfYear];
    
    UIButton *year=[[UIButton alloc]initWithFrame:CGRectMake(150, 350, 50, 35)];
    [year setTitle:@"一年" forState:0];
    [year.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [year setTitleColor:[UIColor blackColor] forState:0];
    [year setBackgroundColor:[UIColor yellowColor]];
    year.tag=103;
    [year addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:year];

    
}

//计算百分比
- (NSMutableArray *)caluleteMultiple:(NSArray *)arr yArray:(NSArray *)yMaxArray{
    CGFloat maxValue = [[yMaxArray valueForKeyPath:@"@max.floatValue"] floatValue];
    NSLog(@"%f",maxValue);
    NSMutableArray *endArray=[NSMutableArray array];
    for (id value in arr) {
        CGFloat multipleValue=1.0-[value floatValue]/maxValue;
        multipleValue=multipleValue>=1.0?1.0:multipleValue;
        multipleValue=multipleValue<=0?0:multipleValue;
        
        NSString *stringVlue=[NSString stringWithFormat:@"%f",multipleValue];
        [endArray addObject:stringVlue];
    }
    return endArray;
}


- (void)select:(UIButton *)sender{
    switch (sender.tag) {
        case 100:
        {
            lineView.dataArr =[self caluleteMultiple:@[@"0",@"3000",@"5000",@"1000",@"2000",@"5000",@"0"] yArray:@[@"0",@"1000",@"2000",@"3000",@"4000",@"5000",@"6000"]];
            lineView.xArray=@[@"6月",@"7月",@"8月",@"9月",@"10月",@"11月",@"12月"];
            lineView.yArray=@[@"0",@"1000",@"2000",@"3000",@"4000",@"5000",@"6000"];
            lineView.xtitleColor=[UIColor redColor];
            lineView.ytitleColor=[UIColor redColor];
            lineView.xlineColor=[UIColor blueColor];
            lineView.ylineColor=[UIColor clearColor];
            lineView.tableViewBgColor=[UIColor clearColor];
            lineView.btnColor=[UIColor greenColor];
            lineView.btnLineColor=[UIColor greenColor];
            lineView.fillColorArray= @[(__bridge id)[[UIColor greenColor]colorWithAlphaComponent:0.2].CGColor,(__bridge id)[[UIColor yellowColor]colorWithAlphaComponent:0.5].CGColor];
        }
            break;
        case 101:
        {
            lineView.dataArr =[self caluleteMultiple:@[@"30",@"20",@"10",@"60",@"10",@"20",@"40"] yArray:@[@"0",@"10",@"20",@"30",@"40",@"50",@"60"]];
            lineView.xArray=@[@"1月",@"2月",@"3月",@"4月",@"5月",@"6月",@"7月"];
            lineView.yArray=@[@"0",@"10",@"20",@"30",@"40",@"50",@"60"];
            lineView.xtitleColor=[UIColor greenColor];
            lineView.ytitleColor=[UIColor greenColor];
            lineView.xlineColor=[UIColor lightGrayColor];
            lineView.ylineColor=[UIColor clearColor];
            lineView.tableViewBgColor=[UIColor clearColor];
            lineView.btnColor=[UIColor yellowColor];
            lineView.btnLineColor=[UIColor yellowColor];
            lineView.fillColorArray= @[(__bridge id)[[UIColor yellowColor]colorWithAlphaComponent:0.2].CGColor,(__bridge id)[[UIColor blackColor]colorWithAlphaComponent:0.5].CGColor];
        }
            break;
        case 102:
        {
            lineView.dataArr =[self caluleteMultiple:@[@"600",@"300",@"100",@"400",@"100",@"600",@"100"] yArray:@[@"0",@"100",@"200",@"300",@"400",@"500",@"600"]];
            lineView.xArray=@[@"2001",@"2002",@"2003",@"2004",@"2005",@"2006",@"2007"];
            lineView.yArray=@[@"0",@"100",@"200",@"300",@"400",@"500",@"600"];
            lineView.xtitleColor=[UIColor darkGrayColor];
            lineView.ytitleColor=[UIColor darkGrayColor];
            lineView.xlineColor=[UIColor lightGrayColor];
            lineView.ylineColor=[UIColor clearColor];
            lineView.tableViewBgColor=[UIColor clearColor];
            lineView.btnColor=[UIColor blackColor];
            lineView.btnLineColor=[UIColor blackColor];
            lineView.fillColorArray= @[(__bridge id)[[UIColor redColor]colorWithAlphaComponent:0.2].CGColor,(__bridge id)[[UIColor greenColor]colorWithAlphaComponent:0.5].CGColor];
        }
            break;
        case 103:
        {
            lineView.dataArr =[self caluleteMultiple:@[@"0",@"6000",@"0",@"4000",@"2000",@"6000",@"0"] yArray:@[@"0",@"100",@"200",@"300",@"400",@"500",@"600"]];
            lineView.xArray=@[@"1",@"2",@"3",@"4",@"5",@"6",@"7"];
            lineView.yArray=@[@"0",@"100",@"200",@"300",@"400",@"500",@"600"];
            lineView.xtitleColor=[UIColor darkGrayColor];
            lineView.ytitleColor=[UIColor darkGrayColor];
            lineView.xlineColor=[UIColor lightGrayColor];
            lineView.ylineColor=[UIColor clearColor];
            lineView.tableViewBgColor=[UIColor clearColor];
            lineView.btnColor=[UIColor greenColor];
            lineView.btnLineColor=[UIColor greenColor];
            lineView.fillColorArray= @[(__bridge id)[[UIColor blackColor]colorWithAlphaComponent:0.2].CGColor,(__bridge id)[[UIColor redColor]colorWithAlphaComponent:0.5].CGColor];
        }
            break;
        default:
            break;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
