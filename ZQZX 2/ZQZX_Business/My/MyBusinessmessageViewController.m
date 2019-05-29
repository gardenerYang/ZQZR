//
//  MyBusinessmessageViewController.m
//  ZQZX
//
//  Created by 中企 on 2018/11/2.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "MyBusinessmessageViewController.h"
#import "PhotoTableViewCell.h"
#import "MyTableViewCell.h"
#import "SRActionSheet.h"
#import "GTMBase64.h"
#import "QNManage.h"
#import "HttpRequest+MyBusiness.h"

@interface MyBusinessmessageViewController ()<SRActionSheetDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,strong)QNModel *qnModel;

@end

@implementation MyBusinessmessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setCustomerTitle:@"我的信息"];
    _titleArr = [NSArray arrayWithObjects:@"绑定手机",@"真实姓名",@"身份证号", nil];
    [self setTableViewEdges:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.tableView registerClass:[PhotoTableViewCell class] forCellReuseIdentifier:NSStringFromClass([PhotoTableViewCell class])];
    [self getQNUploadtoken];
}
-(void)getQNUploadtoken{
    [HttpRequest getQNTokenRequestsuccess:^(QNModel * _Nonnull model, NSString * _Nonnull message) {
        self.qnModel = model;
    } failure:^(NSError * _Nonnull error) {
//        NSLog(@"%@",error.localizedDescription);
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 3;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        PhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PhotoTableViewCell class]) forIndexPath:indexPath];
        cell.titleLb.text = _myModel.username;
        [cell.photoImg sd_setImageWithString:_myModel.headImageUrl];;
        
        return cell;
    }else if (indexPath.section == 1){
        static NSString *CellIdentifier = @"Cell";
        MyTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            cell = [[MyTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier type:cellTypeDefault];
        }
        cell.titleLb.text = _titleArr[indexPath.row];
        //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.row == 0) {
            cell.srcLb.text = _myModel.phone;
            
        }else if (indexPath.row == 1){
            cell.srcLb.text = _myModel.realName;
            
        }
        else{
            cell.srcLb.text = _myModel.idNo;
            
        }
        [cell updateLB];
        
        return cell;
    }else{
        static NSString *CellIdentifier = @"Cell";
        MyTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            cell = [[MyTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier type:cellTypeDefault];
        }
        cell.titleLb.text = @"理财师推荐码";
        cell.srcLb.text = _myModel.referralCode;
        [cell updateLB];
        return cell;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
//MARK: delegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && indexPath.row == 0) {
        SRActionSheet *actionSheet = [SRActionSheet sr_actionSheetViewWithTitle:@"上传头像"
                                                                    cancelTitle:@"取消"
                                                               destructiveTitle:nil
                                                                    otherTitles:@[@"从相册选择", @"拍取照片"]
                                                                    otherImages:nil
                                                               selectSheetBlock:^(SRActionSheet *actionSheet, NSInteger index) {
                                                                   NSLog(@"%zd", index);
                                                                   if (index==0) {
                                                                       //打开本地相册
                                                                       [self LocalPhoto];
                                                                   }
                                                                   else if (index==1)
                                                                   {
                                                                       //打开照相机拍照
                                                                       [self takePhoto];
                                                                   }
                                                                   else
                                                                   {
                                                                       
                                                                   }
                                                               }];
        [actionSheet show];
    }
    
}

-(void)takePhoto

{//判断是否可以打开相机，模拟器此功能无法使用
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController * picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.allowsEditing = YES;  //是否可编辑
        //摄像头
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:nil];
        
    }else{
        //如果没有提示用户
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"你没有摄像头" delegate:nil cancelButtonTitle:@"Drat!" otherButtonTitles:nil];
        [alert show];
    }
}//打开本地相册

-(void)LocalPhoto

{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}

//当选择一张图片后进入这里

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info

{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //当选择的类型是图片
    
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        //设置image的尺寸
        CGSize imagesize = image.size;
        NSLog(@"%f,%f",imagesize.height,imagesize.width);
        if (imagesize.width>imagesize.height&&imagesize.height>500) {
            imagesize.width=500*imagesize.width/imagesize.height;
            imagesize.height=500;
        }
        if (imagesize.width<=imagesize.height&&imagesize.width>500) {
            imagesize.height=500*imagesize.height/imagesize.width;
            imagesize.width=500;
        }
        NSLog(@"%f,%f",imagesize.height,imagesize.width);
        image = [self imageWithImage:image scaledToSize:imagesize];
        NSData *data ;
        if (UIImagePNGRepresentation(image) == nil)
        {
            data = UIImageJPEGRepresentation(image, 0.1);
        }
        else
        {
            data =UIImageJPEGRepresentation(image,0.1);
        }
        
        
        [[QNManage sharedInstance] upManager];
        [[QNManage sharedInstance]qiuNiu:image token:self.qnModel.token url:self.qnModel.doman success:^(NSString * _Nonnull imgurl) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            PhotoTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            [cell.photoImg sd_setBigImageWithString:imgurl];
            
            [HttpRequest updateFinancialPlannerInfoID:@"" corpId:@"" employeesNo:@"" password:@"" username:@"" realname:@"" phone:@"" email:@"" rate:@"" level:@"" levelName:@"" province:@"" city:@"" status:@"" addTime:@"" addIp:@"" superiorId:@"" superiorName:@"" referralCode:@"" headImageUrl:imgurl Requestsuccess:^(HttpResponse * _Nonnull data, NSString * _Nonnull message) {
                [MBProgressHUD showSuccessMessage:@"头像上传成功"];
            } failure:^(NSError * _Nonnull error) {
                NSLog(@"%@",error.localizedDescription);
                [MBProgressHUD showErrorMessage:@"头像上传服务器失败"];

            }];
            
            
            
        } failure:^(NSError * _Nonnull err) {

            [MBProgressHUD showErrorMessage:@"七牛云头像更新失败"];
        }];
        
        
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:nil];
        
        
        
        
    }
}



-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize

{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
