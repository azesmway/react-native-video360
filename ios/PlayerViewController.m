
#import "PlayerViewController.h"
#import <SGPlayer/SGPlayer.h>
#import <SGPlayer/SGVideoRenderer.h>

@interface PlayerViewController ()
@property (nonatomic, assign) BOOL seeking;
@property (nonatomic, assign) SGStateInfo state;
@property (nonatomic, strong) SGPlayer *player;

@property (weak, nonatomic) IBOutlet UISlider *progressSlider;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *playPauseButton;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *muteButton;
@end

@implementation PlayerViewController

- (instancetype)init
{
    if (self = [super init]) {
        self.player = [[SGPlayer alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(infoChanged:) name:SGPlayerDidChangeInfosNotification object:self.player];
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.player.videoRenderer.view = self.view;
    self.player.videoRenderer.displayMode = SGDisplayModeVR;
    [self.player replaceWithURL:[NSURL URLWithString:self.urlVideo]];
    [self.player play];

    return;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (Boolean)isMuted
{
    return self.player.audioRenderer.volume == 0.0;
}

- (void)infoChanged:(NSNotification *)notification
{
    SGTimeInfo time = [SGPlayer timeInfoFromUserInfo:notification.userInfo];
    SGInfoAction action = [SGPlayer infoActionFromUserInfo:notification.userInfo];
    self.state = [SGPlayer stateInfoFromUserInfo:notification.userInfo];
    
    if (action & SGInfoActionTime) {
        if (action & SGInfoActionTimePlayback && !(self.state.playback & SGPlaybackStateSeeking) && !self.seeking && !self.progressSlider.isTracking) {
            self.progressSlider.value = CMTimeGetSeconds(time.playback) / CMTimeGetSeconds(time.duration);
        }
    }
    
    if (self.state.playback & SGPlaybackStatePlaying) {
        [self.playPauseButton setImage:[self getImageNamed:@"Pause"] forState:UIControlStateNormal];
    } else {
        [self.playPauseButton setImage:[self getImageNamed:@"Play"] forState:UIControlStateNormal];
    }

    [self updateMuteIcon];
}

- (void)updateMuteIcon
{
    if ([self isMuted]) {
        [self.muteButton setImage:[self getImageNamed:@"Unmute"] forState:UIControlStateNormal];
    } else {
        [self.muteButton setImage:[self getImageNamed:@"Mute"] forState:UIControlStateNormal];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)playVideoFromUrl:(NSURL*)vrVideo
{
    [self.player replaceWithURL:vrVideo];
}

- (IBAction)playOrPause:(id)sender
{
    if (self.state.playback & SGPlaybackStatePlaying) {
        [self.player pause];
        return;
    }

    [self.player play];
}

- (IBAction)mute:(id)sender
{
    if ([self isMuted]) {
        [self.player.audioRenderer setVolume:1.0];
    } else {
        [self.player.audioRenderer setVolume:0.0];
    }
    
    [self updateMuteIcon];
}

- (IBAction)progressTouchUp:(id)sender
{
    CMTime time = CMTimeMultiplyByFloat64(self.player.currentItem.duration, self.progressSlider.value);
    if (!CMTIME_IS_NUMERIC(time)) {
        time = kCMTimeZero;
    }
    self.seeking = YES;
    [self.player seekToTime:time result:^(CMTime time, NSError *error) {
        self.seeking = NO;
    }];
}

- (UIImage *) getImageNamed: (NSString *)imageName {
    NSString *resourcePath = [NSBundle.mainBundle pathForResource:@"Resources" ofType:@"bundle"];
    NSBundle *resourcesBundle = [NSBundle bundleWithPath:resourcePath];
    return [UIImage imageNamed:imageName inBundle:resourcesBundle compatibleWithTraitCollection:nil];
}

@end
