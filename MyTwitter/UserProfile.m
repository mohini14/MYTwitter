//
//  UserProfile.m
//  MyTwitter
//
//  Created by Mohini on 18/02/17.
//  Copyright © 2017 Mohini. All rights reserved.
//

#import "UserProfile.h"
#import "Post.h"

@interface UserProfile ()

@end

@implementation UserProfile{
    NSInteger clickedRowNumber;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _nameLabel.text= _dict[@"username"];
    _emailIdLabel.text= _dict[@"email"];
    self.postsTableData = [@[] mutableCopy];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self populateData];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.postsTableData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostTableCell *cell= [tableView dequeueReusableCellWithIdentifier:@"PostTableCell"];
    
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PostTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }

    Post *post = _postsTableData[indexPath.row];

    cell.usernameLabel.text=post.user.username;
    cell.postedAtLabel.text=post.createdAt.description;
    cell.postLabel.text=post.post;


    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    clickedRowNumber = indexPath.row;
    [self onClickFromSelectedRowToComments];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  120;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



-(void)populateData{
    [UserServices getAllPost:^(BOOL isSuccess, NSArray *posts, NSString *errorMessage) {
        if(isSuccess==TRUE){
//            self.postsTableData = [@[] mutableCopy];
//            for (NSDictionary *obj in data[@"results"]){//for each loop to retrieve data from json;
//
//                NSDictionary *tempDict=@{
//                        @"post":obj[@"post"],
//                        @"date":obj[@"created_at"],
//                        @"username":obj[@"user"][@"username"],
//                        @"post_id":obj[@"id"],
//						@"likes":obj[@"likes"],
//                        @"created_at":obj[@"created_at"]
//
//                };
//                [self.postsTableData addObject:tempDict];
//            }
            self.postsTableData = posts;
            [self.tableView reloadData];
        }else if(isSuccess==FALSE && errorMessage!=nil){
            [AlertManager showAlertPopupWithTitle:@"Failed" andMessage:@"server error" andActionTitle:@"ok" forView:self];
        } else{
            [AlertManager showAlertPopupWithTitle:@"Failed" andMessage:@"something went wrong" andActionTitle:@"ok" forView:self];
        }

    }];
}



-(IBAction)unwindFromUserPost:(UIStoryboardSegue *)segue{
    if([segue.identifier isEqualToString:@"unwindFromUSerPost"]){
        [self populateData];//getting the new post added from userPost VC so that can be added to tableview
    
        
    }
}

-(IBAction)unwindFromCommentVC:(UIStoryboardSegue *)segue{
    
}


-(void) onClickFromSelectedRowToComments{
	
    [self performSegueWithIdentifier:@"UserPofileToComment" sender:self];

}




-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"UserProfileToUserPost"]){
        UserPost *up = segue.destinationViewController.childViewControllers[0];
        up.userProfileDict = self.dict;
    }

    if([segue.identifier isEqualToString:@"UserPofileToComment"]){
        CommentViewController *destination = segue.destinationViewController.childViewControllers[0];
		NSMutableDictionary *tempDict=[[NSMutableDictionary alloc]init];
       tempDict = [[_postsTableData objectAtIndex:clickedRowNumber] mutableCopy];
		NSString *usernameToComments= [_dict valueForKey:@"username"];
		[tempDict setValue:usernameToComments forKey:@"usernameToComments"];
		destination.dict = tempDict;
}

}
    @end

