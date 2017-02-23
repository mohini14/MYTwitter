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
    [self setup];

    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) setup{

    self.sessionData=[SessionData getInstance];
    self.nameLabel.text= self.sessionData.loggedInUser.username;
    self.emailIdLabel.text= self.sessionData.loggedInUser.email;
    self.postsTableData = [@[] mutableCopy];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self populateData];
    

}


#pragma tableViewDelegates
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

    // to convert id interface from index of array to particular object that array holds
    Post *post = self.postsTableData[indexPath.row];

    cell.usernameLabel.text=post.user.username;
    cell.postedAtLabel.text=post.createdAt.description;
    cell.postLabel.text=post.post;
    if([post.user.username isEqualToString: self.sessionData.loggedInUser.username ]) {
        cell.editButton.tag = indexPath.row;//to keep info about which button is pressed.
        [cell.editButton addTarget:self action:@selector(postEditButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        cell.editButton.hidden = NO;
    } else{
        cell.editButton.hidden = YES;
    }
    return cell;
}

-(void)postEditButtonPressed:(UIButton *)sender{
    NSInteger rowClicked = sender.tag;
    self.sessionData.postToBeEdited = self.postsTableData[rowClicked];
    [self performSegueWithIdentifier:@"UserProfileToUserPost" sender:self];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    //PostTableCell *cell = tableView[1]
    clickedRowNumber = indexPath.row;
    [self onClickFromSelectedRowToComments];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  120;
}


-(void)populateData{
    [UserServices getAllPost:^( NSArray *posts, NSString *errorMessage) {
        if(errorMessage==nil){
            self.postsTableData = posts;
            [self.tableView reloadData];
        }else 
            [AlertManager showAlertPopupWithTitle:@"Failed" andMessage:errorMessage andActionTitle:@"ok" forView:self];
			
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
//    if([segue.identifier isEqualToString:@"UserProfileToUserPost"]){
//        UserPost *up = segue.destinationViewController.childViewControllers[0];
//        up.userProfileDict = self.dict;
//    }

    if([segue.identifier isEqualToString:@"UserPofileToComment"]){
        CommentViewController *destination = segue.destinationViewController.childViewControllers[0];
//		NSString *usernameToComments= [_dict valueForKey:@"username"];
        Post *post = _postsTableData[clickedRowNumber];
        [SessionData getInstance].currentPost=post;
//		destination.displayPost = post;
		
		
}

}
    @end

