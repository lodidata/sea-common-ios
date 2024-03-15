//
//  WLAwardMsgCell.m
//  NEW
//
//  Created by wulin on 2022/1/27.
//

#import "WLAwardMsgCell.h"
#import "Masonry.h"

@interface WLAwardMsgCell ()
@property(nonatomic,strong) UIView * bgView;
@end

@implementation WLAwardMsgCell

-(UIView *)bgView {
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor colorWithRed:44.0/255 green:44.0/255 blue:44.0/255 alpha:1];
        _bgView.layer.cornerRadius = 5;
        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
}

-(UILabel *)textLab {
    if (_textLab == nil) {
        _textLab = [[UILabel alloc] init];
        _textLab.textColor = [UIColor colorWithRed:233.0/255 green:193.0/255 blue:99.0/255 alpha:1];
    }
    return _textLab;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithRed:27.0/255 green:27.0/255 blue:27.0/255 alpha:1];
        [self.contentView addSubview:self.bgView];
        [self.contentView addSubview:self.textLab];
    }
    return self;
}
-(void)layoutSubviews {
    [super layoutSubviews];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *maker) {
        maker.left.equalTo(@(15));
        maker.right.equalTo(@(-15));
        maker.top.equalTo(self.contentView);
        maker.bottom.equalTo(@(-5));
        
    }];
    [self.textLab mas_makeConstraints:^(MASConstraintMaker *maker) {
        maker.left.equalTo(@(30));
        maker.right.equalTo(@(-15));
        maker.top.equalTo(self.contentView);
        maker.bottom.equalTo(@(-5));
    }];
}

@end
