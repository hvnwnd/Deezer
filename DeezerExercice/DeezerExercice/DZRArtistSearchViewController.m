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
#import "UIViewController+Error.h"
#import "DZRLoadingView.h"
#import "DZRTransitionManager.h"

@interface DZRArtistSearchViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;
@property (nonatomic, weak) IBOutlet DZRLoadingView *loadingView;

@property (nonatomic) DZRTransitionManager *transitionManager;

@property (nonatomic, strong) NSArray *artists;
@property (nonatomic) DZRRequestService *requestService;
@end

@implementation DZRArtistSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.searchBar becomeFirstResponder];
    self.loadingView.hidden = YES;
    self.loadingView.layer.cornerRadius = 8.0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (DZRTransitionManager *)transitionManager{
    if (!_transitionManager){
        _transitionManager = [DZRTransitionManager new];
    }
    return _transitionManager;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showArtist"]){
        DZRArtistDetailViewController *detailViewController = (DZRArtistDetailViewController *)segue.destinationViewController;
        DZRArtistCollectionViewCell *cell = (DZRArtistCollectionViewCell *)sender;
        detailViewController.artistId = cell.artistId;
        detailViewController.title = cell.artistName;
        
        detailViewController.transitioningDelegate = self.transitionManager;
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
    self.loadingView.hidden = NO;
    __weak typeof (self) weakSelf = self;
    NSString *escapedString = [name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self.requestService searchArtistWithText:escapedString completion:^(NSArray *result, NSError *error) {
        self.loadingView.hidden = YES;

        if (result){
            weakSelf.artists = result;
            [weakSelf.collectionView reloadData];
        }else{
            [weakSelf showError:error];
        }
    }];
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
    static NSString *cellIdentifier = @"ArtistCollectionViewCellIdentifier";

    DZRArtistCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    DZRArtist *artist = self.artists[indexPath.row];
    [cell updateWithArtistId:artist.identifier
                        name:artist.artistName
                    imageUrl:artist.artistPictureUrl];

    return cell;
}

@end
