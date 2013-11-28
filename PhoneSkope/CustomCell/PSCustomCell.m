

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

- (void)setDataForCustomCell:(PSFilterObject *)data;
{
    self.titleLabel.text = data.name;
    self.detailLabel.text = @"";
    
    switch (data.cellType) {
        case CellCheckChoice:
        {
            self.switchBtn.hidden = YES;
            self.arrowBtn.hidden = YES;
            if (data.isChecked)
                self.checkBtn.hidden = NO;
            else
                self.checkBtn.hidden = YES;
        }
            break;
        case CellManyChoice:
        {
            self.detailLabel.text = data.value;
            self.switchBtn.hidden = YES;
            self.arrowBtn.hidden = NO;
            self.checkBtn.hidden = YES;
        }
            break;
        case CellSwithChoice:
        {
            self.switchBtn.hidden = NO;
            self.arrowBtn.hidden = YES;
            self.checkBtn.hidden = YES;
            
        }
            break;
        case CellNone:
        {
            self.switchBtn.hidden = YES;
            self.arrowBtn.hidden = YES;
            self.checkBtn.hidden = YES;

        }
            break;
            
        default:
        {
            self.switchBtn.hidden = YES;
            self.arrowBtn.hidden = YES;
            self.checkBtn.hidden = YES;
        }
            break;
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
