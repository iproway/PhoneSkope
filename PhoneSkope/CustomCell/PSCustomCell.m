

#import "PSCustomCell.h"

@implementation PSCustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)customSwitchSetStatus:(CustomSwitchStatus)status filterData:(PSFilterData *)data atIndex:(int)index;
{
    NSLog(@"Switch Status = %d", status);
    BOOL isOn = NO;
    if (status == 1) {
        isOn = YES;
    }
    
    if ([_switchDelegate respondsToSelector:@selector(changeSwitchStatus:filterData:atIndex:)]) {
        [_switchDelegate changeSwitchStatus:isOn filterData:data atIndex:index];
    }
}

- (void)setDataForCustomCell:(PSFilterData *)data;
{
    self.titleLabel.text = data.filterTitle;
    
    self.detailLabel.text = @"";
    if (data.indexValue != -1 && data.arrayValue && data.indexValue < data.arrayValue.count) {
        self.detailLabel.text = [data.arrayValue objectAtIndex:data.indexValue];
    }
    
    self.switchBtn.delegate = self;
    
    if (!self.isChild) {
        self.checkBtn.hidden = YES;
        
        if (data.switchValue != -1) {
            self.switchBtn.hidden = NO;
            [self.switchBtn setData:data];
                        
            [self.switchBtn setStatus:data.switchValue];
            
            self.arrowBtn.hidden = YES;
        } else {
            self.switchBtn.hidden = YES;
            self.arrowBtn.hidden = NO;
        }
        
    } else {

        self.switchBtn.hidden = YES;
        self.arrowBtn.hidden = YES;
        
        self.titleLabel.text = [data.arrayValue objectAtIndex:self.tag];
        self.detailLabel.text = @"";

        if (data.indexValue == self.tag) {
            self.checkBtn.hidden = NO;
        } else {
            self.checkBtn.hidden = YES;
        }
    }
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    self.backgroundColor = [UIColor clearColor];
    if (![self.switchBtn isHidden]) {
        return;
    }
    
//    [super setHighlighted:highlighted animated:animated];
    
    if (highlighted) {
        self.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"segment_1px_selected.png"]];
    } else {
        self.contentView.backgroundColor = [UIColor clearColor];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    self.backgroundColor = [UIColor clearColor];
    if (![self.switchBtn isHidden]) {
        return;
    }
    
//    [super setSelected:selected animated:animated];

    if (selected) {
        self.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"segment_1px_selected.png"]];
    } else {
        self.contentView.backgroundColor = [UIColor clearColor];
    }
}

@end
