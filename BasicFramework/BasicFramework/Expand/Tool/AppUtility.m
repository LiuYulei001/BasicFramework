

#define stateLabelTextColor kRGB(90, 90, 90)

#import "AppUtility.h"
#import "MJRefresh.h"

@implementation AppUtility

/** 开始下拉刷新*/
+ (void)beginPullRefreshForScrollView:(UIScrollView *)scrollView {
    [scrollView.mj_header beginRefreshing];
}

/**判断头部是否在刷新*/
+ (BOOL)headerIsRefreshForScrollView:(UIScrollView *)scrollView {
    
    BOOL flag =  scrollView.mj_header.isRefreshing;
    return flag;
}

/**判断是否尾部在刷新*/
+ (BOOL)footerIsLoadingForScrollView:(UIScrollView *)scrollView {
    return  scrollView.mj_footer.isRefreshing;
}

/**提示没有更多数据的情况*/
+ (void)noticeNoMoreDataForScrollView:(UIScrollView *)scrollView {
    [scrollView.mj_footer endRefreshingWithNoMoreData];
}

/**重置footer*/
+ (void)resetNoMoreDataForScrollView:(UIScrollView *)scrollView {
    [scrollView.mj_footer resetNoMoreData];
}

/**停止下拉刷新*/
+ (void)endRefreshForScrollView:(UIScrollView *)scrollView {
    [scrollView.mj_header endRefreshing];
}

/**停止上拉加载*/
+ (void)endLoadMoreForScrollView:(UIScrollView *)scrollView {
    [scrollView.mj_footer endRefreshing];
}

/** 隐藏footer*/
+ (void)hiddenFooterForScrollView:(UIScrollView *)scrollView {
    // 不确定是哪个类型的footer
    scrollView.mj_footer.hidden = YES;
}

/**隐藏header*/
+ (void)hiddenHeaderForScrollView:(UIScrollView *)scrollView {
    scrollView.mj_header.hidden = YES;
}

/**上拉*/
+ (void)addLoadMoreForScrollView:(UIScrollView *)scrollView
                loadMoreCallBack:(RefreshAndLoadMoreHandle)loadMoreCallBackBlock {
    
    if (scrollView == nil || loadMoreCallBackBlock == nil) {
        return ;
    }
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (loadMoreCallBackBlock) {
            loadMoreCallBackBlock();
        }
    }];
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    [footer setTitle:@"内涵正在为您加载数据" forState:MJRefreshStateRefreshing];
    [footer setTitle:@"没有更多了~" forState:MJRefreshStateNoMoreData];
    footer.stateLabel.textColor = stateLabelTextColor;
    footer.stateLabel.font = ThirteenFontSize;
//    footer.automaticallyHidden = YES;
    scrollView.mj_footer = footer;
    footer.backgroundColor = kClearColor;
    
    
}

/**下拉*/
+ (void)addPullRefreshForScrollView:(UIScrollView *)scrollView
                pullRefreshCallBack:(RefreshAndLoadMoreHandle)pullRefreshCallBackBlock {
    __weak typeof(UIScrollView *)weakScrollView = scrollView;
    if (scrollView == nil || pullRefreshCallBackBlock == nil) {
        return ;
    }
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (pullRefreshCallBackBlock) {
            pullRefreshCallBackBlock();
        }
        if (weakScrollView.mj_footer.hidden == NO) {
            [weakScrollView.mj_footer resetNoMoreData];
        }
        
    }];
    
    [header setTitle:@"释放更新" forState:MJRefreshStatePulling];
    [header setTitle:@"正在更新" forState:MJRefreshStateRefreshing];
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    header.stateLabel.font = ThirteenFontSize;
    header.stateLabel.textColor = stateLabelTextColor;
    header.lastUpdatedTimeLabel.hidden = YES;
    
    scrollView.mj_header = header;
}


















@end
