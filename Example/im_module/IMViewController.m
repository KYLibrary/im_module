//
//  IMViewController.m
//  im_module
//
//  Created by kyleboy on 03/31/2020.
//  Copyright (c) 2020 kyleboy. All rights reserved.
//

#import "IMViewController.h"
#import "EMChatViewController.h"
#import "EMConversationsViewController.h"
#import "EMHomeViewController.h"

@interface IMViewController ()

@property (nonatomic, strong) NSArray *dateArr;

@end

@implementation IMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.dateArr = @[
        @"进入聊天页面",
        @"进入会话页面",
        @"发送扩展消息",
        @"进入App",
    ];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dateArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.dateArr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: {
            [self jumpChat:nil];
        }
            break;
        case 1: {
            [self jumpConversations:nil];
        }
            break;
        case 2: {
            [self sendMessage1];
        }
            break;
        case 3: {
            [self sendApp];
        }
            break;
        default:
            break;
    }
}

- (void)sendApp {
    EMHomeViewController *homeViewController = [[EMHomeViewController alloc] init];
    [self presentViewController:homeViewController animated:YES completion:nil];
}

- (void)sendMessage1{
    // 以单聊消息举例
    EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithText:@"\"小明\"是您的专属导师，您可尊享一对一服务！有关福利、攻略、疑问等可立即联系导师咨询，导师在线哦~，谁离开的房间爱上了；大富科技sdjfa"];

    NSString *from = [[EMClient sharedClient] currentUsername];

    //生成Message
    EMMessage *message = [[EMMessage alloc] initWithConversationID:@"user1" from:from to:@"user1" body:body ext:nil];
    message.chatType = EMChatTypeChat;// 设置为单聊消息
    message.ext = @{@"d_t":@(1)}; // 扩展消息部分
    
    [[EMClient sharedClient].chatManager sendMessage:message progress:^(int progress) {
        
    } completion:^(EMMessage *message, EMError *error) {
        
    }];
}

- (void)jumpConversations:(id)sender {
    EMConversationsViewController *conversationsViewController = [[EMConversationsViewController alloc] init];
    [self.navigationController pushViewController:conversationsViewController animated:YES];
}

- (void)jumpChat:(id)sender {
    // ConversationId接收消息方的环信ID:@"user2"
    // type聊天类型:EMConversationTypeChat    单聊类型
    // createIfNotExist 如果会话不存在是否创建会话：YES
    EMChatViewController *chatController = [[EMChatViewController alloc] initWithConversationId:@"user1" type:EMConversationTypeChat createIfNotExist:YES];
    
    [self.navigationController pushViewController:chatController animated:YES];
    [[EMClient sharedClient].chatManager getAllConversations];
}
@end

