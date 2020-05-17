//
//  EMHomeViewController.m
//  ChatDemo-UI3.0
//
//  Created by XieYajie on 2018/12/24.
//  Copyright © 2018 XieYajie. All rights reserved.
//

#import "EMHomeViewController.h"

#import "EMConversationsViewController.h"
#import "EMContactsViewController.h"
#import "EMSettingsViewController.h"
#import "EMRemindManager.h"

#define kTabbarItemTag_Conversation 0
#define kTabbarItemTag_Contact 1
#define kTabbarItemTag_Settings 2

@interface EMHomeViewController ()<EMChatManagerDelegate, EMNotificationsDelegate>

@property (nonatomic) BOOL isViewAppear;

@property (nonatomic, strong) EMConversationsViewController *conversationsController;
@property (nonatomic, strong) EMContactsViewController *contactsController;
@property (nonatomic, strong) EMSettingsViewController *settingsController;
@property (nonatomic, strong) UIView *addView;

@end

@implementation EMHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self _setupSubviews];
    
    //监听消息接收，主要更新会话tabbaritem的badge
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
    //监听通知申请，主要更新联系人tabbaritem的badge
    [[EMNotificationHelper shared] addDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    self.isViewAppear = YES;
    [self _loadTabBarItemsBadge];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.isViewAppear = NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}
- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (void)dealloc
{
    [[EMClient sharedClient].chatManager removeDelegate:self];
    [[EMNotificationHelper shared] removeDelegate:self];
}

#pragma mark - Subviews

- (void)_setupSubviews
{
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout: UIRectEdgeNone];
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *settingItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tabbar_settings_gray" bundleName:@"Home.bundle" inBundleForClass:[self class]]
                                                                    style:UIBarButtonItemStyleDone
                                                                   target:self
                                                                   action:@selector(jumpSettingsPage)];
    UIBarButtonItem *contactItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tabbar_contacts_gray" bundleName:@"Home.bundle" inBundleForClass:[self class]]
                                                                       style:UIBarButtonItemStyleDone
                                                                      target:self
                                                                      action:@selector(jumpContactPage)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem, contactItem];

    [self _setupChildController];
}

- (UITabBarItem *)_setupTabBarItemWithTitle:(NSString *)aTitle
                                    imgName:(NSString *)aImgName
                            selectedImgName:(NSString *)aSelectedImgName
                                        tag:(NSInteger)aTag
{
    UITabBarItem *retItem = [[UITabBarItem alloc] initWithTitle:aTitle image:[UIImage imageNamed:aImgName bundleName:@"Home.bundle" inBundleForClass:[self class]] selectedImage:[UIImage imageNamed:aSelectedImgName bundleName:@"Home.bundle" inBundleForClass:[self class]]];
    retItem.tag = aTag;
    [retItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIFont systemFontOfSize:14], NSFontAttributeName, [UIColor lightGrayColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [retItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13], NSFontAttributeName, kColor_Blue, NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    return retItem;
}

- (void)_setupChildController
{
    self.conversationsController = [[EMConversationsViewController alloc] init];
    UITabBarItem *consItem = [self _setupTabBarItemWithTitle:@"聊天" imgName:@"tabbar_chat_gray" selectedImgName:@"tabbar_chat_blue" tag:kTabbarItemTag_Conversation];
    self.conversationsController.tabBarItem = consItem;
    [self addChildViewController:self.conversationsController];
    
    [self.view addSubview:self.conversationsController.view];
    [self.addView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - EMChatManagerDelegate

- (void)messagesDidReceive:(NSArray *)aMessages
{
    if (self.isViewAppear) {
        [self _loadConversationTabBarItemBadge];
    }
}

- (void)conversationListDidUpdate:(NSArray *)aConversationList
{
    [self _loadConversationTabBarItemBadge];
}

#pragma mark - EMNotificationsDelegate

- (void)didNotificationsUnreadCountUpdate:(NSInteger)aUnreadCount
{
    if (aUnreadCount > 0) {
        self.contactsController.tabBarItem.badgeValue = @(aUnreadCount).stringValue;
    } else {
        self.contactsController.tabBarItem.badgeValue = nil;
    }
}

#pragma mark - Private

- (void)_loadConversationTabBarItemBadge
{
    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
    NSInteger unreadCount = 0;
    for (EMConversation *conversation in conversations) {
        unreadCount += conversation.unreadMessagesCount;
    }
    
    NSString *unreadCountStr = unreadCount > 0 ? @(unreadCount).stringValue : nil;
    self.conversationsController.tabBarItem.badgeValue = unreadCountStr;
    [EMRemindManager updateApplicationIconBadgeNumber:unreadCount];
}

- (void)_loadTabBarItemsBadge
{
    [self _loadConversationTabBarItemBadge];
    
    [self didNotificationsUnreadCountUpdate:[EMNotificationHelper shared].unreadCount];
}

#pragma mark - Jump
- (void)jumpSettingsPage {
    EMSettingsViewController *settingsController = [[EMSettingsViewController alloc] init];
    settingsController.title = @"聊天设置";
    settingsController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:settingsController animated:YES];
}

- (void)jumpContactPage {
    EMContactsViewController *contactsController = [[EMContactsViewController alloc] init];
    contactsController.title = @"朋友";
    contactsController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:contactsController animated:YES];
}

@end
