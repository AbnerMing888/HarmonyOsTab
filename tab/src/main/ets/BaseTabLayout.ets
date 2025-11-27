import { BaseTabAttribute } from './BaseTabAttribute'
import { TabModel } from './TabModel'
import { TabType } from './TabType'
import { componentUtils, display } from '@kit.ArkUI'

/**
 * AUTHOR:AbnerMing
 * DATE:2024/2/20
 * INTRODUCE:自定义TabLayout基类
 * */
@Component
export struct BaseTabLayout {
  @Prop tabBar: Array<string> = []
  tabWidth: Length = '100%' //tab指示器的宽度
  @Prop tabHeight: Length = 56 //tab指示器的高度
  @State contentHeight: Length = "100%" //内容的高度
  onChangePage?: (position: number) => void //页面切换
  onTabBarClick?: (position: number) => void //tab点击
  @Prop currentIndex: number = 0 //默认选中第0个
  @Prop tabScrollable: boolean = true //默认可以滑动
  tabsController: TabsController = new TabsController()
  @BuilderParam itemPage: (index: number, item: string) => void //tab对应得页面
  @BuilderParam itemTab: (index: number, item: string) => void //tab对应得Tap按钮
  @BuilderParam itemTabIndicator: () => void //tab对应得Indicator
  tabModel?: TabModel //数据模型
  isHideDivider: boolean = true //是否隐藏下划线，默认展示
  isTabAlignLeft: boolean = false //是否从最左边开始
  scroller: Scroller = new Scroller()
  isIndicatorScroll: boolean = false //指示器是否滑动,默认不滑动
  isShowTabMenu: boolean = false //是否展示右边的按钮选项
  @BuilderParam tabMenu?: () => void
  @BuilderParam tabLeftMenu?: () => void //左侧按钮
  tabMenuWidth: number = 0 //tab右侧按钮的宽度
  tabMenuMarginRight: number = 0 //tab按钮距离右侧的距离
  barMode: BarMode = BarMode.Scrollable //默认滑动
  @Prop isTabClickIntercept?: boolean = false //tab点击拦截
  barBackgroundColor?: ResourceColor = Color.Transparent
  tabType: TabType = TabType.SCROLL
  barPosition?: BarPosition = BarPosition.Start //位置
  private baseTabAttribute: BaseTabAttribute = new BaseTabAttribute()
  onTabAttribute?: (tabAttribute: BaseTabAttribute) => void //tab下划线相关属性
  private tabId: number = 0 //标记id
  @State private tabLeftEndWidth: Length = "100%" //用于记录tab的宽度
  @State private tabFoldableWidth: number = 0 //折叠宽度

  aboutToAppear(): void {


    if (this.onTabAttribute != undefined) {
      this.onTabAttribute(this.baseTabAttribute)
    }

    if (this.tabModel?.tabDividerLineCapStyle == LineCapStyle.Round
      && this.tabModel.tabDividerWidth == 100) {
      this.tabModel.tabDividerWidth = 90 //默认改为90
    }

    this.tabId = this.getUniqueId()

    //必须带有右侧按钮
    if (display.isFoldable() && this.tabMenu != undefined) {
      display.on('foldDisplayModeChange', (_: display.FoldDisplayMode) => {
        let width = px2vp(display.getDefaultDisplaySync().width)
        this.tabLeftEndWidth = width - this.tabFoldableWidth
      })
    }
  }

  @Builder
  tabItem(index: number, item: string) {
    this.itemTab(index, item)
  }

  build() {
    if (this.tabType == TabType.DEFAULT) {
      //默认
      this.tabLayout(this, TabType.DEFAULT)
    } else if (this.tabType == TabType.SCROLL_CENTER) {
      this.tabLayout(this, TabType.SCROLL_CENTER)
    } else {
      this.tabLayoutScroll(this)
    }
  }

  @Builder
  tabLayout(_this: BaseTabLayout, tabType: TabType) {
    Tabs({
      barPosition: _this.barPosition,
      controller: _this.tabsController,
      index: _this.currentIndex
    }) {
      //使用tabBar对象形式传递
      ForEach(_this.tabBar, (item: string, index: number) => {
        if (tabType == TabType.SCROLL_CENTER) {
          TabContent() {
            Column() {
              if (_this.itemPage != undefined) {
                _this.itemPage(index, item)
              }
            }.onAreaChange((_: Area, newValue: Area) => {
              if (newValue.height != 0) {
                this.contentHeight = Number(newValue.height) + Number(_this.tabHeight)
              }
            })
          }
          .tabBar(new SubTabBarStyle(this.tabBar[index])
            .indicator({
              color: this.baseTabAttribute.tabDividerColor, // 下划线颜色
              height: this.baseTabAttribute.tabDividerHeight, // 下划线高度
              width: this.baseTabAttribute.tabDividerWidth, // 下划线宽度
              borderRadius: this.baseTabAttribute.tabDividerRadius, // 下划线圆角半径
              marginTop: this.baseTabAttribute.tabDividerMarginTop // 下划线与文字间距
            })
            .selectedMode(SelectedMode.INDICATOR)
            .labelStyle({
              selectedColor: this.baseTabAttribute.tabSelectedColor,
              unselectedColor: this.baseTabAttribute.tabNormalColor,
              minFontSize: this.baseTabAttribute.tabNormalSize,
              maxFontSize: this.baseTabAttribute.tabSelectedSize,
            })
          )
        } else {
          TabContent() {
            Column() {
              if (_this.itemPage != undefined) {
                _this.itemPage(index, item)
              }
            }.onAreaChange((_: Area, newValue: Area) => {
              if (newValue.height != 0) {
                this.contentHeight = Number(newValue.height) + Number(_this.tabHeight)
              }
            })
          }.tabBar(_this.tabItem(index, item))
        }
      }, (item: string, index: number) => JSON.stringify(item) + "_" + index)
    }
    .height(this.contentHeight)
    .barWidth(_this.tabWidth) //设置宽度
    .barHeight(_this.tabHeight) //设置高度
    .scrollable(_this.tabScrollable) //是否可滑动
    .barMode(_this.barMode) //默认可滑动
    .barBackgroundColor(_this.barBackgroundColor)
    .onChange((index) => {
      if (_this.onChangePage != undefined) {
        _this.onChangePage(index)
      }
      if (_this.isTabClickIntercept) {
        return
      }
      _this.currentIndex = index //改变索引位置
    })
    .onTabBarClick((position) => {

      if (_this.onTabBarClick != null) {
        _this.onTabBarClick(position)
      }

      if (_this.isTabClickIntercept) {
        return
      }
      //tab点击
      _this.currentIndex = position

    })
  }

  //===================以下是滑动逻辑===============

  @State private indicatorLeftMargin: number = 0;
  @State indicatorWidth: number = 0;
  private swipeRatio: number = 0.5;
  private tabsWidth: number = 0;
  @State focusIndex: number = 0;
  private listScroller: Scroller = new Scroller();
  @State private tabIndicatorWidth: number = 0 //指示器的宽度
  tabIndicatorBorder?: BorderOptions //tab指示器边框样式

  @Builder
  tabLayoutScroll(_this: BaseTabLayout) {
    Stack({ alignContent: Alignment.TopStart }) {
      Column() {
        Row() {
          if (_this.tabLeftMenu != undefined) {
            Column() {
              _this.tabLeftMenu()
            }.onAreaChange((_: Area, newValue: Area) => {
              let width = px2vp(display.getDefaultDisplaySync().width)
              if (display.isFoldable()) {
                if (this.tabFoldableWidth == 0) {
                  this.tabFoldableWidth = Number(newValue.width)
                  this.tabLeftEndWidth = width - Number(newValue.width)
                }
              } else {
                //不可折叠
                this.tabLeftEndWidth = width - Number(newValue.width)
              }
            })
          }

          List({ initialIndex: 0, scroller: _this.listScroller }) {
            ForEach(_this.tabBar, (item: string, index: number) => {
              _this.TabBarLayout(item, index)
            }, (item: string, index: number) => JSON.stringify(item) + index)
          }
          .listDirection(Axis.Horizontal)
          .width(this.tabLeftEndWidth)
          .height("100%")
          .scrollBar(BarState.Off)
          .onWillScroll((xOffset: number) => {
            _this.indicatorLeftMargin -= xOffset;
          })
          .layoutWeight(1)

          if (_this.tabMenu != undefined) {
            Column() {
              _this.tabMenu()
            }.onAreaChange((_: Area, newValue: Area) => {
              let width = px2vp(display.getDefaultDisplaySync().width)
              if (display.isFoldable()) {
                if (this.tabFoldableWidth == 0) {
                  this.tabFoldableWidth = Number(newValue.width)
                  this.tabLeftEndWidth = width - Number(newValue.width)
                }
              } else {
                //不可折叠
                this.tabLeftEndWidth = width - Number(newValue.width)
              }
            })

          }
        }
        .height(_this.tabHeight)
        .width("100%")
      }.width("100%")
      .alignItems(HorizontalAlign.Center)
      .backgroundColor(this.barBackgroundColor)
      .border(this.tabIndicatorBorder)

      //指示器
      Column() {
        if (_this.itemTabIndicator != undefined) {
          _this.itemTabIndicator()
        }
      }
      .width((Number(_this.tabModel?.tabDividerWidth) < Number(_this.tabModel?.tabItemWidth)) ?
        _this.tabModel?.tabItemWidth :
        _this.tabModel?.tabDividerWidth == undefined ? _this.tabIndicatorWidth :
          _this.tabIndicatorWidth) //是否要根据文字宽度进行设置
      .justifyContent(FlexAlign.Center)
      .margin({
        left: this.tabModel?.tabDividerMarginLeft != undefined ?
          _this.indicatorLeftMargin - Number(this.tabModel?.tabDividerMarginLeft) : _this.indicatorLeftMargin,
        top: Number(_this.tabHeight) -
        Number(_this.tabModel?.tabDividerStrokeWidth == undefined ? 3 : _this.tabModel?.tabDividerStrokeWidth) -
        Number(_this.tabModel?.tabDividerMarginBottom == undefined ? 0 : _this.tabModel?.tabDividerMarginBottom)
      })
    }
    .width("100%")
    .height(_this.tabHeight)
    .onAreaChange(() => {
      let targetIndexInfo = _this.getTextInfo(_this.currentIndex);
      _this.startAnimateTo(300, targetIndexInfo.left, targetIndexInfo.width);
      _this.listScroller.scrollToIndex(_this.currentIndex, true, ScrollAlign.CENTER);
    })

    Tabs({ barPosition: BarPosition.Start, index: _this.currentIndex, controller: this.tabsController }) {
      ForEach(_this.tabBar, (item: string, index: number) => {
        TabContent() {
          if (_this.itemPage != undefined) {
            Column() {
              _this.itemPage(index, item)
            }.onAreaChange((_: Area, newValue: Area) => {
              _this.contentHeight = newValue.height
            })
          }
        }
      }, (item: string, index: number) => JSON.stringify(item) + index)
    }
    .onChange((index: number) => {
      if (_this.onChangePage != undefined) {
        _this.onChangePage(index)
      }
      if (_this.isTabClickIntercept) {
        return
      }
      _this.currentIndex = index //改变索引位置
    })
    .onAreaChange((_: Area, newValue: Area) => {
      let width = Number.parseFloat(newValue.width.toString());
      _this.tabsWidth = Number.isNaN(width) ? 0 : width;
      _this.tabIndicatorWidth = _this.getTextInfo(0).width //初始化
    })
    .width("100%")
    .barHeight(0)
    .height(_this.contentHeight)
    .animationDuration(300)
    .scrollable(_this.tabScrollable)
    .onAnimationStart((_: number, targetIndex: number) => {
      _this.focusIndex = targetIndex;
      let targetIndexInfo = _this.getTextInfo(targetIndex);
      _this.tabIndicatorWidth = targetIndexInfo.width
      _this.startAnimateTo(300, targetIndexInfo.left, targetIndexInfo.width);
    })
    .onAnimationEnd((index: number, event: TabsAnimationEvent) => {

      let currentIndicatorInfo = _this.getCurrentIndicatorInfo(index, event);
      _this.startAnimateTo(0, currentIndicatorInfo.left, currentIndicatorInfo.width);
      _this.listScroller.scrollToIndex(index, true, index == 0 ? ScrollAlign.START : ScrollAlign.CENTER);
    })
    .onGestureSwipe((index: number, event: TabsAnimationEvent) => {
      let currentIndicatorInfo = _this.getCurrentIndicatorInfo(index, event);
      _this.focusIndex = currentIndicatorInfo.index;
      _this.indicatorLeftMargin = currentIndicatorInfo.left;
      _this.tabWidth = currentIndicatorInfo.width;
      _this.indicatorWidth = currentIndicatorInfo.width;
    })
  }

  @Builder
  TabBarLayout(tabName: string, tabIndex: number) {
    Row() {
      Stack() {
        if (this.itemTab != undefined) {
          this.itemTab(tabIndex, tabName)
        }
      }.id(tabIndex.toString() + "_" + this.tabId)
      .onAreaChange((_: Area, newValue: Area) => {
        if (this.focusIndex === tabIndex &&
          (this.indicatorLeftMargin === 0 || this.indicatorWidth === 0)) {
          if (newValue.position.x != undefined) {
            let positionX = Number.parseFloat(newValue.position.x.toString());
            this.indicatorLeftMargin = Number.isNaN(positionX) ? 0 : positionX;
          }
          let width = Number.parseFloat(newValue.width.toString());
          this.tabWidth = Number.isNaN(width) ? 0 : width;
          this.indicatorWidth = this.tabWidth;
        }
      })
    }
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      if (this.onTabBarClick != null) {
        this.onTabBarClick(tabIndex)
      }
      if (this.isTabClickIntercept) {
        return
      }
      this.tabsController.changeIndex(tabIndex);
      this.focusIndex = tabIndex;

    })
  }

  /**
   * AUTHOR:AbnerMing
   * INTRODUCE:文本内容信息
   * */
  private getTextInfo(index: number): Record<string, number> {
    let modePosition: componentUtils.ComponentInfo =
      this.getUIContext().getComponentUtils().getRectangleById(index.toString() + "_" + this.tabId);
    return { 'left': px2vp(modePosition.windowOffset.x), 'width': px2vp(modePosition.size.width) }
  }

  /**
   * AUTHOR:AbnerMing
   * INTRODUCE:获取偏移量信息
   * */
  private getCurrentIndicatorInfo(index: number, event: TabsAnimationEvent): Record<string, number> {
    let nextIndex = index;
    if (index > 0 && event.currentOffset > 0) {
      nextIndex--;
    } else if (index < this.tabBar.length && event.currentOffset < 0) {
      nextIndex++;
    }
    let indexInfo = this.getTextInfo(index);
    let nextIndexInfo = this.getTextInfo(nextIndex);
    let swipeRatio = Math.abs(event.currentOffset / this.tabsWidth);
    let currentIndex = swipeRatio > this.swipeRatio ? nextIndex : index;
    let currentLeft = indexInfo.left + (nextIndexInfo.left - indexInfo.left) * swipeRatio;
    let currentWidth = indexInfo.width + (nextIndexInfo.width - indexInfo.width) * swipeRatio;
    return { 'index': currentIndex, 'left': currentLeft, 'width': currentWidth };
  }

  private startAnimateTo(duration: number, leftMargin: number, width: number) {
    this.getUIContext().animateTo({
      duration: duration,
      curve: Curve.Linear,
      iterations: 1,
      playMode: PlayMode.Normal,
    }, () => {
      this.indicatorLeftMargin = leftMargin;
      this.indicatorWidth = width;
    })
  }
}