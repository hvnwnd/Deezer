//
//  DZRArtistSearchViewController.m
//  DeezerExercice
//  Copyright (c) 2015 Deezer. All rights reserved.
//

#import "DZRArtistSearchViewController.h"
#import "DZRArtistDetailViewController.h"
#import "DZRArtistCollectionViewCell.h"
#import "DZRArtist.h"
#import "UIViewController+Error.h"
#import "DZRLoadingView.h"
#import "DZRTransitionManager.h"
#import "DZRArtistSearchViewModel.h"

NSString *const kDZRArtistSearchViewModelResultKey = @"searchResult";
NSString *const kDZRArtistSearchViewModelErrorKey = @"error";

@interface DZRArtistSearchViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;
@property (nonatomic, weak) IBOutlet DZRLoadingView *loadingView;

@property (nonatomic) DZRTransitionManager *transitionManager;
@property (nonatomic) DZRArtistSearchViewModel *viewModel;

@end

@implementation DZRArtistSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.searchBar becomeFirstResponder];
    self.loadingView.hidden = YES;
    self.loadingView.layer.cornerRadius = 8.0;
    self.navigationController.delegate = self.transitionManager;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Accessors

- (DZRTransitionManager *)transitionManager{
    if (!_transitionManager){
        _transitionManager = [DZRTransitionManager new];
    }
    return _transitionManager;
}

- (DZRArtistSearchViewModel *)viewModel{
    if (!_viewModel)
    {
        _viewModel = [DZRArtistSearchViewModel new];
        [_viewModel addObserver:self forKeyPath:kDZRArtistSearchViewModelResultKey options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial context:NULL];
        [_viewModel addObserver:self forKeyPath:kDZRArtistSearchViewModelErrorKey options:NSKeyValueObservingOptionNew context:NULL];
    }
    return _viewModel;
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

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:kDZRArtistSearchViewModelResultKey]) {
        self.loadingView.hidden = YES;
        [self.collectionView reloadData];
    } else if ([keyPath isEqualToString:kDZRArtistSearchViewModelErrorKey]){
        [self showError:self.viewModel.error];
    } else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc{
    [self.viewModel removeObserver:self forKeyPath:kDZRArtistSearchViewModelResultKey];
    [self.viewModel removeObserver:self forKeyPath:kDZRArtistSearchViewModelErrorKey];
}

#pragma mark - Search

- (void)searchArtistsWithName:(NSString *)name {
    self.loadingView.hidden = NO;
    [self.viewModel searchWithText:name];
}

#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self performSelector:@selector(searchArtistsWithName:) withObject:searchText afterDelay:0.5];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.viewModel.searchResult.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ArtistCollectionViewCellIdentifier";

    DZRArtistCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    DZRArtist *artist = self.viewModel.searchResult[indexPath.row];
    [cell updateWithArtistId:artist.identifier
                        name:artist.artistName
                    imageUrl:artist.artistPictureUrl];

    return cell;
}

@end
