//
//  customPopupViewController.m
//  Lab6-Alert&PopupView
//
//  Created by 張力元 on 2019/2/25.
//  Copyright © 2019 張力元. All rights reserved.
//

#import "customPopupViewController.h"

@interface customPopupViewController ()
@property (strong, nonatomic) IBOutlet UIView *popupView;
@end

@implementation customPopupViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)showInVC:(UIViewController *)vc{
    //設定顯示類型，此類型可以不將前一個頁面Disappear，並將此畫面直接覆蓋在前一個頁面上
    [self setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    
    // 設定動畫效果
    CATransition* transition = [CATransition animation];
    //動畫時間（秒）
    transition.duration = 0.25;
    //動畫類型：淡化
    transition.type = kCATransitionFade;
    //新增動畫至欲顯示的畫面上
    [vc.view.window.layer addAnimation:transition forKey:kCATransition];
    //顯示此Popup View Controller
    [vc presentViewController:self animated:false completion:^{
        //設定popup View動畫 從0.5倍長寬且完全透明
        self.popupView.transform = CGAffineTransformMakeScale(0.5, 0.5);
        self.popupView.alpha = 0;
        //經0.25秒後 變為1倍長寬且完全不透明
        [UIView animateWithDuration:.25 animations:^{
            self.popupView.alpha = 1;
            self.popupView.transform = CGAffineTransformMakeScale(1, 1);
        }];
    }];
}

- (IBAction)selectFood:(UIButton *)sender {
    //此畫面消失
    [self dismissView:nil];
    //將選取結果透過Block傳出
    _block([sender titleForState:UIControlStateNormal]);
}

- (IBAction)dismissView:(id)sender {
    //與顯示時相同 設定消失的動畫
    CATransition* transition = [CATransition animation];
    transition.duration = 0.25;
    transition.type = kCATransitionFade;
    [self.view.window.layer addAnimation:transition forKey:kCATransition];
    [self dismissViewControllerAnimated:false completion:nil];
}
@end
