import { TabModel } from './TabModel'
import display from '@ohos.display'

/**
 * AUTHOR:AbnerMing
 * DATE:2024/2/20
 * INTRODUCE:自定义底部TabLayout
 * */

@Component
export struct SlideTab {
  tabWidth: Length = '100%' //tab指示器的宽度
  @Prop tabHeight: Length = 56 //tab指示器的高度
  @Prop tabBar: Array<string> = []
  onChangePage?: (position: number) => void
  onTabBarClick?: (position: number) => void
  @BuilderParam itemPage: (index: number, item: string) => void //tab对应得页面
  @BuilderParam itemTab: (index: number, item: string) => void //tab对应得Tap按钮
  @BuilderParam itemIndicator: (index: number, item: string) => void //tab对应得Tap指示器
  @Prop currentIndex: number = 0
  @State private _privateCurrentTabIndex: number = 0
  private _privateScroller: Scroller = new Scroller()
  @State _privateCurrentDividerIndex: number = 0
  @State _privateIndicatorLeftMargin: number = 0
  @State private _privateDividerDuration: number = 0 //下划线时间
  @State private _privateIndexIndicatorWidth: number = 0 //第一个指示器宽度
  @State private _privateScrollIndicatorWidth: Length = 0 //滑动指示器的宽度
  @State private _privateWindowWidth: number = 0 //窗口的宽度
  private _privateLastIndicatorLeftMargin: number = 0 //最后移动的距离
  @State private _privateIsShowDivider: boolean = false //用来控制是否显示
  private tabModel: TabModel = new TabModel() //数据模型
  tabAttribute?: (attribute: TabModel) => void //tab相关属性
  barMode: BarMode = BarMode.Scrollable //默认滑动
  @Prop isShowTabMenu: boolean = false //是否展示右边的按钮选项
  @BuilderParam tabMenu?: () => void
  tabMenuWidth: Length = 0 //tab右侧按钮的宽度
  tabMenuMarginRight: number = 0 //tab按钮距离右侧的距离
  @State private tabFoldableWidth: number = 0 //折叠宽度
  /**
   * AUTHOR:AbnerMing
   * INTRODUCE:tab右侧按钮的位置
   * */
  private tabMenuAlignRue: Record<string, Record<string, string | VerticalAlign | HorizontalAlign>> = {
    'top': { 'anchor': '__container__', 'align': VerticalAlign.Top },
    'right': { 'anchor': '__container__', 'align': HorizontalAlign.End },
    'bottom': { 'anchor': '__container__', 'align': VerticalAlign.Bottom }
  }

  aboutToAppear() {
    if (this.tabAttribute != null) {
      this.tabAttribute(this.tabModel)
    }
    this._privateCurrentTabIndex = this.currentIndex
    this._privateCurrentDividerIndex = this.currentIndex
    setTimeout(() => {
      this._privateIndicatorLeftMargin = this._privateScroller.getItemRect(this.currentIndex).x
      this._privateLastIndicatorLeftMargin = this._privateIndicatorLeftMargin
    }, 500)

    //必须带有右侧按钮
    if (display.isFoldable() && this.tabMenu != undefined) {
      display.on('foldDisplayModeChange', (_: display.FoldDisplayMode) => {
        let width = px2vp(display.getDefaultDisplaySync().width)
        this._privateWindowWidth = width - this.tabFoldableWidth
      })
    }
  }

  build() {
    Column() {

      //自定义TabBar，考虑到右侧有按钮，需要外层加一个布局
      if (this.isShowTabMenu) {
        RelativeContainer() {
          this.listTab()
          //右侧按钮
          Column() {
            if (this.tabMenu != null) {
              this.tabMenu()
            }
          }
          .alignRules(this.tabMenuAlignRue)
          .id("tab_menu")
          .margin({ right: this.tabMenuMarginRight })
          .width(this.tabMenuWidth)
          .height(this.tabHeight)
        }.width('100%')
        .height(this.tabHeight)
      } else {
        this.listTab()
      }
      // 下划线
      if (this.itemIndicator == undefined) {
        Row() {
          Row() {
            Divider()
              .width(this.tabModel.tabDividerWidth != undefined ? this.tabModel.tabDividerWidth :
              this._privateScrollIndicatorWidth)
              .color(this.tabModel.tabDividerColor)
              .strokeWidth(this.tabModel.tabDividerStrokeWidth)
              .height(this.tabModel.tabDividerStrokeWidth)
              .lineCap(this.tabModel.tabDividerLineCapStyle)
          }
          .width(this._privateScrollIndicatorWidth)
          .offset({ x: this._privateIndicatorLeftMargin })
          .justifyContent(FlexAlign.Center)
          .animation({
            duration: this._privateDividerDuration, onFinish: () => {
              this._privateDividerDuration = 0
            }
          })
        }
        .justifyContent(FlexAlign.Start)
        .width("100%")
        .height(this.tabModel.tabDividerStrokeWidth)
        .margin({ top: -Number(this.tabModel.tabDividerStrokeWidth) })
        .visibility(this._privateIsShowDivider ? Visibility.Visible : Visibility.Hidden)
      }


      Swiper() {
        ForEach(this.tabBar, (item: string, index: number) => {
          if (this.itemPage != undefined) {
            this.itemPage(index, item)
          }
        }, (item: string) => JSON.stringify(item))
      }
      .width("100%")
      .onAreaChange((_: Area, newValue: Area) => {
        if (this._privateWindowWidth == 0) {
          this._privateWindowWidth = Number(newValue.width)
          if (this.isShowTabMenu) {
            //展示再减去
            this.tabFoldableWidth = Number(this.tabMenuWidth)
            this._privateWindowWidth = Number(newValue.width) - Number(this.tabMenuWidth)
          }
        }
      })
      .indicator(false)
      .autoPlay(false)
      .loop(false)
      .index(this.currentIndex)
      .onAnimationEnd(() => {
        if (this.onChangePage != undefined) {
          this.onChangePage(this.currentIndex)
        }
        this._privateIndicatorLeftMargin = this._privateScroller.getItemRect(this.currentIndex).x
        this._privateLastIndicatorLeftMargin = this._privateIndicatorLeftMargin
      })
      .onChange((index: number) => {
        this.currentIndex = index

      })
      .onAnimationStart((index: number, targetIndex: number, _: SwiperAnimationEvent) => {
        this._privateIsShowDivider = false
        this._privateCurrentDividerIndex = targetIndex

        if (index == targetIndex) {
          this._privateIndicatorLeftMargin = this._privateScroller.getItemRect(targetIndex).x
          this._privateLastIndicatorLeftMargin = this._privateIndicatorLeftMargin
          return
        }
        this.scrollItem(targetIndex)
      })
      .onGestureSwipe((index: number, event: TabsAnimationEvent) => {
        if (event.currentOffset < 0 && index >= this.tabBar.length - 1) {
          return
        }
        this._privateIsShowDivider = true
        let indicatorWidth = this._privateScroller.getItemRect(index).width //获取条目的
        this._privateScrollIndicatorWidth = indicatorWidth
        // 在页面跟手滑动过程中，逐帧触发该回调。
        let offset = event.currentOffset

        let proportion = Math.abs(offset) / this._privateWindowWidth //比例
        if (offset < 0) {
          //往右滑动
          let nextWidth = this._privateScroller.getItemRect(index + 1).width //设置滑动指示器宽度
          let maxProportion = 1.5
          this._privateIndicatorLeftMargin =
            this._privateLastIndicatorLeftMargin + (indicatorWidth * maxProportion) * proportion
          //如果大于就等于
          let endX = this._privateScroller.getItemRect(index + 1).x

          // if (nextWidth > indicatorWidth) {
          //   endX = this.scroller.getItemRect(index + 1).x + (nextWidth - indicatorWidth)
          // } else {
          //   endX = this.scroller.getItemRect(index + 1).x - (indicatorWidth - nextWidth)
          // }
          // console.log(this.indicatorLeftMargin + "====" + endX)

          if (this._privateIndicatorLeftMargin > endX) {
            this._privateIndicatorLeftMargin = endX
          }
        } else {
          //往左滑动
          //this.scrollIndicatorWidth = this.scroller.getItemRect(index - 1).width //设置滑动指示器宽度
          this._privateIndicatorLeftMargin = this._privateLastIndicatorLeftMargin - (indicatorWidth * 1.5) * proportion
          //如果小于就等于

          if (this._privateIndicatorLeftMargin < this._privateScroller.getItemRect(index - 1).x) {
            this._privateIndicatorLeftMargin = this._privateScroller.getItemRect(index - 1).x
          }
        }
      })
    }
  }

  private clickItem(index: number) {
    this.currentIndex = index
    this._privateCurrentTabIndex = index
    this._privateCurrentDividerIndex = index
    this._privateIsShowDivider = false //让可滑动下划线展示
    this.scrollItem(index)
    if (this.onTabBarClick != undefined) {
      this.onTabBarClick(index)
    }
    if (this.onChangePage != undefined) {
      this.onChangePage(index)
    }
    setTimeout(() => {
      this._privateIndicatorLeftMargin = this._privateScroller.getItemRect(index).x
      this._privateLastIndicatorLeftMargin = this._privateIndicatorLeftMargin
    }, 300)
  }

  //滑动条目
  private scrollItem(targetIndex: number) {
    this._privateCurrentTabIndex = targetIndex
    let offset = this._privateScroller.currentOffset().xOffset + this._privateScroller.getItemRect(targetIndex).x
      - this._privateWindowWidth / 2 + this._privateScroller.getItemRect(targetIndex).width / 2
    this._privateScroller.scrollTo({
      xOffset: offset,
      yOffset: 0,
      animation: { duration: 300 }
    })
  }

  @Builder
  listTab() {
    List({ initialIndex: this.currentIndex, scroller: this._privateScroller, space: 0 }) {
      ForEach(this.tabBar, (item: string, index: number) => {
        ListItem() {
          Column() {
            if (this.itemTab != undefined) {
              //自定义tab
              this.itemTab(index, item)
            } else {

              Text(item.toString())
                .height(Number(this.tabHeight) - Number(this.tabModel.tabDividerStrokeWidth))
                .fontColor(this._privateCurrentTabIndex == index ? this.tabModel.tabSelectedColor :
                this.tabModel.tabNormalColor)
                .fontSize(this._privateCurrentTabIndex == index ? this.tabModel.tabSelectedSize :
                this.tabModel.tabNormalSize)
                .fontWeight(this._privateCurrentTabIndex == index ? this.tabModel.tabSelectedWeight :
                this.tabModel.tabNormalWeight)
                .lineHeight(this.tabModel.tabLineHeight)
                .margin(this.tabModel.tabMargin)
            }

            //指示器
            if (this.itemIndicator != undefined) {
              Stack() {
                this.itemIndicator(index, item)
              }
            } else {
              Divider()
                .width(this.tabModel.tabDividerWidth != undefined ? this.tabModel.tabDividerWidth :
                  (this._privateIndexIndicatorWidth != 0 ? this._privateIndexIndicatorWidth :
                  this._privateScroller.getItemRect(index).width))
                .color(this.tabModel.tabDividerColor)
                .lineCap(this.tabModel.tabDividerLineCapStyle)
                .height(this.tabModel.tabDividerStrokeWidth)
                .strokeWidth(this.tabModel.tabDividerStrokeWidth)
                .visibility((!this._privateIsShowDivider && this._privateCurrentDividerIndex == index) ?
                Visibility.Visible :
                Visibility.Hidden)
            }
          }
          .backgroundColor(this.currentIndex === index ? this.tabModel.tabSelectedBgColor :
          this.tabModel.tabNormalBgColor)
        }
        .width(this.barMode == BarMode.Fixed ? (this._privateWindowWidth / this.tabBar.length) : undefined)
        .onAreaChange(() => {
          if (index == 0) {
            this._privateIndexIndicatorWidth = this._privateScroller.getItemRect(0).width
            this._privateScrollIndicatorWidth = this._privateIndexIndicatorWidth //当前条目的宽度
          }
        })
        .onClick(() => {
          //点击事件
          //点击，让下划线可移动
          this.clickItem(index)
        })
      }, (item: Object) => JSON.stringify(item))
    }
    .width(this._privateWindowWidth)
    .height(this.tabHeight)
    .scrollBar(BarState.Off)
    .listDirection(Axis.Horizontal)
    .edgeEffect(EdgeEffect.Spring)
    .listDirection(Axis.Horizontal)
    .id("tab_item")
    .onScrollStart(() => {
      this._privateIsShowDivider = false //让可滑动下划线隐藏
    })
  }
}