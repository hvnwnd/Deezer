//
//  DZRArtistSearchViewController.m
//  DeezerExercice
//  Copyright (c) 2015 Deezer. All rights reserved.
//

#import "DZRArtistSearchViewController.h"
#import "DZRArtistDetailViewController.h"
#import "DZRArtistCollectionViewCell.h"
#import "DZRRequestService.h"
#import "DZRArtist.h"

@interface DZRArtistSearchViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) NSArray *artists;

@property (nonatomic) DZRRequestService *requestService;
@end

@implementation DZRArtistSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showArtist"]){
        DZRArtistDetailViewController *detailViewController = (DZRArtistDetailViewController *)segue.destinationViewController;
        DZRArtistCollectionViewCell *cell = (DZRArtistCollectionViewCell *)sender;
        detailViewController.artistId = cell.artistId;
        detailViewController.title = cell.artistName;
    }
}

- (DZRRequestService *)requestService{
    if (!_requestService)
    {
        _requestService = [DZRRequestService new];
    }
    return _requestService;
}

#pragma - Search

- (void)searchArtistsWithName:(NSString *)name {
    __weak typeof (self) weakSelf = self;
    [self.requestService searchArtistWithText:name completion:^(NSArray *result, NSError *error) {
        if (result){
            weakSelf.artists = result;
            [weakSelf.collectionView reloadData];
        }else{
            [weakSelf showError:error];
        }
    }];
}

- (void)showError:(NSError *)error{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:[error localizedDescription]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

#pragma - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self performSelector:@selector(searchArtistsWithName:) withObject:searchText afterDelay:0.5];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

#pragma - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.artists.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ArtistCollectionViewCellIdentifier";

    DZRArtistCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    DZRArtist *artist = self.artists[indexPath.row];
    [cell updateWithArtistId:artist.artistIdentifier
                        name:artist.artistName
                    imageUrl:artist.artistPictureUrl];

    return cell;
}

@end
