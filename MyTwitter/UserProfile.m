//
//  UserProfile.m
//  MyTwitter
//
//  Created by Mohini on 18/02/17.
//  Copyright © 2017 Mohini. All rights reserved.
//

#import "UserProfile.h"

@interface UserProfile ()

@end

@implementation UserProfile{
    
    NSMutableArray *tableData ;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    _nameLabel.text= _dict[@"name"];
    _emailIdLabel.text= _dict[@"email"];
    tableData = [@[] mutableCopy];
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
    return tableData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text= tableData[(NSUInteger) indexPath.row][@"post"];
    return cell;
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
    [UserServices getAllPost:^(BOOL isSuccess, NSDictionary *data, NSString *errorMessage) {
        if(isSuccess==TRUE){
            for (NSDictionary *obj in data[@"results"]){//for each loop to retrieve data from json;
                
                NSDictionary *tempDict=@{
                        @"post":obj[@"post"],
                        @"date":obj[@"created_at"],
                        @"username":obj[@"user"][@"username"]
                };
                [tableData addObject:tempDict];
            }

                [self.tableView reloadData];




        }else if(isSuccess==FALSE && errorMessage!=nil){
            [AlertManager showAlertPopupWithTitle:@"Failed" andMessage:@"server error" andActionTitle:@"ok" forView:self];
        } else{
            [AlertManager showAlertPopupWithTitle:@"Failed" andMessage:@"something went wrong" andActionTitle:@"ok" forView:self];
        }


    }];
    
    
    
    
    

    
}

-(IBAction)unwindFromUserPost:(UIStoryboardSegue *)segue{
    
}

@end
