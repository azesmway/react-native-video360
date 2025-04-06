#import "Video360.h"
#import "PlayerViewController.h"

@implementation Video360 {
  PlayerViewController *_playerView;
}

- (instancetype)init
{
  self = [super init];
  if (self) {
    _playerView = [[PlayerViewController alloc] init];
  }

  return self;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  _playerView.view.frame = self.bounds;
  [self addSubview:_playerView.view];
}

- (void)setUrlVideo:(NSString *)urlVideo
{
  if(![	urlVideo isEqual: _urlVideo	 ])
  {
    _urlVideo = urlVideo;
    NSLog(@"%@", urlVideo);
    _playerView.urlVideo = urlVideo;
  }
}

@end
