//
//  AllDoctorBySpecilityTableViewController.m
//  DrugFinder
//
//  Created by Satish on 3/14/17.
//  Copyright © 2017 AppCoda. All rights reserved.
//

#import "AllDoctorBySpecilityTableViewController.h"
#import "DBManager.h"
#import "DoctorFullinfoViewController.h"
@interface AllDoctorBySpecilityTableViewController ()
@property (nonatomic, strong) DBManager *dbManager;

@property (nonatomic, strong) NSArray *arrqueryresult;
@end

@implementation AllDoctorBySpecilityTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Physicians";
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"doctorlist.db"];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // Reload the table view.
    
    
    [self loadData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)loadData{
    // Form the query.
    
    NSString *query =[NSString stringWithFormat:@"select * from list where Physician_Specialty='%@'",self.type] ;
    
    // Get the results.
    
    //    NSArray *arrayWithDuplicates = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    //    NSOrderedSet *orderedSet = [NSOrderedSet orderedSetWithArray:arrayWithDuplicates];
    //    self.arrqueryresult = [orderedSet array];
    self.arrqueryresult = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    //NSLog(@"%@ - %@	",_Zipcode,_arrqueryresult);
    [self.tableView reloadData];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.arrqueryresult.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // Dequeue the cell.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSInteger indexOfFirstname = [self.dbManager.arrColumnNames indexOfObject:@"Physician_First_Name"];
    NSInteger indexOfmiddlename = [self.dbManager.arrColumnNames indexOfObject:@"Physician_Middle_Name"];
    NSInteger indexOflastname = [self.dbManager.arrColumnNames indexOfObject:@"Physician_Last_Name"];
    NSInteger indexOfprimarytype = [self.dbManager.arrColumnNames indexOfObject:@"Physician_Primary_Type"];
    // Set the loaded data to the appropriate cell labels.
    //cell.textLabel.text = [NSString stringWithFormat:@"%@ || %@ || %@", [[self.arrPeopleInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfFirstname], [[self.arrPeopleInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfAddress] , [[self.arrPeopleInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfmobile]];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ %@", [[self.arrqueryresult objectAtIndex:indexPath.row] objectAtIndex:indexOfFirstname],[[self.arrqueryresult objectAtIndex:indexPath.row] objectAtIndex:indexOfmiddlename],[[self.arrqueryresult objectAtIndex:indexPath.row] objectAtIndex:indexOflastname]];
    
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [[self.arrqueryresult objectAtIndex:indexPath.row] objectAtIndex:indexOfprimarytype]];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger indexOfID = [self.dbManager.arrColumnNames indexOfObject:@"Physician_Profile_ID"];
    NSInteger indexOfFname = [self.dbManager.arrColumnNames indexOfObject:@"Physician_First_Name"];
    NSInteger indexOfLname = [self.dbManager.arrColumnNames indexOfObject:@"Physician_Last_Name"];
    NSInteger indexOfAddLine1 = [self.dbManager.arrColumnNames indexOfObject:@"Recipient_Primary_Business_Street_Address_Line1"];
    NSInteger indexOfAddLine2 = [self.dbManager.arrColumnNames indexOfObject:@"Recipient_Primary_Business_Street_Address_Line2"];
    NSInteger indexOfCity = [self.dbManager.arrColumnNames indexOfObject:@"Recipient_City"];
    NSInteger indexOfState = [self.dbManager.arrColumnNames indexOfObject:@"Recipient_State"];
    NSInteger indexOfZipCode = [self.dbManager.arrColumnNames indexOfObject:@"Recipient_Zip_Code"];
    NSInteger indexOfCountry = [self.dbManager.arrColumnNames indexOfObject:@"Recipient_Country"];
    NSInteger indexOfType = [self.dbManager.arrColumnNames indexOfObject:@"Physician_Primary_Type"];
    NSInteger indexOfSpecility = [self.dbManager.arrColumnNames indexOfObject:@"Physician_Specialty"];
    
    DoctorFullinfoViewController *dfd = [self.storyboard instantiateViewControllerWithIdentifier:@"doctorfullinfo"];
    dfd.ProfileID = [[self.arrqueryresult objectAtIndex:indexPath.row] objectAtIndex:indexOfID];
    dfd.FirstName = [[self.arrqueryresult objectAtIndex:indexPath.row] objectAtIndex:indexOfFname];
    dfd.LastName = [[self.arrqueryresult objectAtIndex:indexPath.row] objectAtIndex:indexOfLname];
    dfd.AddLine1 = [[self.arrqueryresult objectAtIndex:indexPath.row] objectAtIndex:indexOfAddLine1];
    dfd.AddLine2 = [[self.arrqueryresult objectAtIndex:indexPath.row] objectAtIndex:indexOfAddLine2];
    dfd.City = [[self.arrqueryresult objectAtIndex:indexPath.row] objectAtIndex:indexOfCity];
    dfd.State = [[self.arrqueryresult objectAtIndex:indexPath.row] objectAtIndex:indexOfState];
    dfd.Zipcode = [[self.arrqueryresult objectAtIndex:indexPath.row] objectAtIndex:indexOfZipCode];
    dfd.Country = [[self.arrqueryresult objectAtIndex:indexPath.row] objectAtIndex:indexOfCountry];
    dfd.Type = [[self.arrqueryresult objectAtIndex:indexPath.row] objectAtIndex:indexOfType];
    dfd.Specility = [[self.arrqueryresult objectAtIndex:indexPath.row] objectAtIndex:indexOfSpecility];
    [self.navigationController pushViewController:dfd animated:YES];
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
