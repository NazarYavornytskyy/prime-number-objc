//
//  ViewController.m
//  SimpleNumberSearcher
//
//  Created by Nazar Yavornytskyy on 2/6/17.
//  Copyright © 2017 @NazarYavornytskyy. All rights reserved.
//

#import "ViewController.h"

#define FILE_TO_READ @"txt1"//@"txt2", @"txt3"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *resultTextView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self readFile];
}

- (void) readFile{
    NSString *fileContents = [self readFromFile:FILE_TO_READ];
    
    NSArray *numbersArray = [fileContents componentsSeparatedByString:@","];
    NSMutableArray* simpleNumbers = [[NSMutableArray alloc] init];
    for (NSString* numberStr in numbersArray){
        int numberInt = numberStr.intValue;
        if ([self isPrime:numberInt]){
            [simpleNumbers addObject:numberStr];
        }
    }
    //If simple number count > 0 then we can create new file which will cantains this numbers
    if (simpleNumbers.count > 0){
        //Write into file
        NSString *resultNumberString = [simpleNumbers componentsJoinedByString:@", "];
        [self saveNumberIntoFile:resultNumberString];
    } else {
        _resultTextView.text = @"There're no prime numbers";
    }
    
}

- (BOOL)isPrime:(int)number{
    BOOL isPrime = YES;
    
    if (number <= 1) {
        isPrime = YES;
    }
    
    if (number != 2 && number != 1){
        
        for (int i = 2; i < number; i++){
            
            if (number % i == 0) {
                isPrime = NO;
            }
        }
    }
    return isPrime;
}

- (NSString*)readFromFile:(NSString*)fileName{
    NSString *filepath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"txt"];
    NSError *error;
    NSString *fileContents = [NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:&error];
    
    if (error)
        NSLog(@"Error reading file: %@", error.localizedDescription);
        _resultTextView.text = error.localizedDescription;
    
    // maybe for debugging...
    NSLog(@"contents: %@", fileContents);
    
    return fileContents;
}

- (void)saveNumberIntoFile:(NSString*)numberAsString{
    NSError *error;
    
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"resultFile.txt"];
    [numberAsString writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if (!error){
        NSLog(@"Success write numbers into file");
        [self loadResultFromFile];
    } else {
        NSLog(@"Failed write numbers into file");
        _resultTextView.text = @"Failed write numbers into file";
    }
}

- (void)loadResultFromFile{
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"resultFile.txt"];
    NSError *error;
    NSString *fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    
    if (error){
        NSLog(@"Error reading file: %@", error.localizedDescription);
        _resultTextView.text = error.localizedDescription;
    }
    NSLog(@"contents: %@", fileContents);
    _resultTextView.text = fileContents;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
