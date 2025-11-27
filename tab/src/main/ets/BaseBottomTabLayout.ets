import { BottomTabType } from './BottomTabType'
import { TabBar } from './TabBar'

/**
 * AUTHOR:AbnerMing
 * DATE:2024/2/20
 * INTRODUCE:自定义底部TabLayout，用于tab自定义
 * */

@Component
export struct BaseBottomTabLayout {
  @BuilderParam itemPage: (index: number, item: TabBar) => void //tab对应得页面
  @BuilderParam itemTab: (index: number, item: TabBar) => void //tab对应得Tap按钮
  tabWidth: Length = '100%' //tab指示器的宽度
  @Prop tabHeight: number = 56 //tab指示器的高度
  @Prop tabBar: Array<TabBar> = []
  tabsController: TabsController = new TabsController()
  @Prop currentIndex: number = 0 //默认选中第0个
  tabScrollable: boolean = false //默认不可以滑动
  onChangePage?: (position: number) => void
  onTabBarClick?: (position: number) => void
  tabIconWidth: number = 20 //图片icon的宽度
  tabIconHeight: number = 20 //图片icon的高度
  tabSelectedColor: ResourceColor = Color.Black //标题选中颜色
  tabNormalColor: ResourceColor = Color.Gray //标题未选中颜色
  tabSelectedBgColor: ResourceColor = Color.Transparent //选中背景颜色
  tabNormalBgColor: ResourceColor = Color.Transparent //未选中背景颜色
  barBackgroundColor: ResourceColor = Color.Transparent //tabBar的背景颜色
  navBarBackgroundColor: ResourceColor = Color.Transparent //底部导航栏背景颜色
  tabLabelMarginTop: number = 5 //标签距离图片的高度
  tabMarginBottom: number = 0 //tab距离底部的距离
  isMarginBottom: boolean = true //默认开启，tab距离底部的距离
  @Prop isTabClickIntercept?: boolean = false //tab点击拦截
  @Prop tabPositionInterceptArray: Array<number> = [] //拦截索引
  onDoubleClick?: (index: number) => void //双击
  centerImageMarginBottom: number = 0 //默认距离底部为0
  centerImageAlign: FlexAlign = FlexAlign.End
  onTabAppear?: () => void
  onTabAttach?: () => void
  bottomTabType?: BottomTabType = BottomTabType.DEFAULT
  bottomTabBorderOptions?: BorderOptions
  bottomTabMargin?: Margin | Length | LocalizedMargin
  barBorder?: BorderOptions //设置tabBar底部边框样式
  barBackgroundEffect?: BackgroundEffectOptions
  tabContentBorder?: BorderOptions //设置tabBar内容边框样式

  @Builder
  tabItem(_this: BaseBottomTabLayout, index: number, item: TabBar) {
    RelativeContainer() {
      Column() {

      }
      .width("100%")
      .height(this.centerImageMarginBottom)
      .id("view_top")
      .backgroundColor(Color.Transparent)
      .alignRules({
        top: { anchor: "__container__", align: VerticalAlign.Top }
      })

      Column() {

      }
      .width("100%")
      .height(this.tabMarginBottom)
      .id("view_bottom")
      .alignRules({
        bottom: { anchor: "__container__", align: VerticalAlign.Bottom }
      })
      .backgroundColor(this.bottomTabType == BottomTabType.ROUNDED ? Color.Transparent : this.navBarBackgroundColor)

      Column() {
        _this.itemTab(index, item)
      }
      .width("100%")
      .height(this.tabHeight)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(this.bottomTabType == BottomTabType.ROUNDED ? Color.Transparent : this.barBackgroundColor)
      .alignRules({
        top: { anchor: "view_top", align: VerticalAlign.Bottom },
        bottom: { anchor: "view_bottom", align: VerticalAlign.Top }
      })
      .border(this.barBorder)

    }
    .layoutWeight(1)
    .gesture(
      TapGesture({ count: 2 })
        .onAction((_: GestureEvent) => {
          if (_this.onDoubleClick != undefined) {
            _this.onDoubleClick(index)
          }
          if (_this.isTabClickIntercept) {
            return
          }
          if (this.tabPositionInterceptArray.includes(index)) {
            return
          }
          _this.currentIndex = index
        })
    )
    .gesture(
      TapGesture()
        .onAction((_: GestureEvent) => {
          //条目点击
          if (_this.onTabBarClick != undefined) {
            _this.onTabBarClick(index)
          }
          if (_this.isTabClickIntercept) {
            return
          }
          if (this.tabPositionInterceptArray.includes(index)) {
            return
          }
          _this.currentIndex = index

        })
    )
  }

  build() {
    if (this.bottomTabType == BottomTabType.ROUNDED) {
      //圆角类型
      RelativeContainer() {
        this.tabRootView()

        Row() {
          ForEach(this.tabBar, (item: TabBar, index: number) => {
            this.tabItem(this, index, item)
          })
        }
        .border(this.bottomTabBorderOptions)
        .height(this.tabHeight)
        .width(this.tabWidth)
        .margin(this.bottomTabMargin)
        .backgroundColor(this.barBackgroundColor)
        .alignRules({
          bottom: { anchor: "__container__", align: VerticalAlign.Bottom },
          left: { anchor: "__container__", align: HorizontalAlign.Start }
        })

      }.width("100%")
      .height("100%")
    } else {
      this.tabRootView()
    }
  }

  @Builder
  tabRootView() {
    Tabs({ barPosition: BarPosition.End, controller: this.tabsController, index: this.currentIndex }) {
      //使用tabBar对象形式传递
      ForEach(this.tabBar, (item: TabBar, index: number) => {
        if (this.bottomTabType != BottomTabType.ROUNDED) {
          TabContent() {
            this.itemPage(index, item)
          }
          .tabBar(this.tabItem(this, index, item))
          .border(this.tabContentBorder)
        } else {
          TabContent() {
            this.itemPage(index, item)
          }.border(this.tabContentBorder)
        }
      })
    }
    .barWidth(this.tabWidth) //设置宽度
    .barHeight(this.bottomTabType == BottomTabType.ROUNDED ? 0 :
      (this.tabHeight + this.tabMarginBottom + this.centerImageMarginBottom)) //设置高度
    //.barBackgroundEffect(this.barBackgroundEffect)
    .scrollable(this.tabScrollable) //是否可滑动
    .onChange((index) => {
      //改变索引
      if (this.isTabClickIntercept) {
        return
      }
      this.currentIndex = index
      if (this.onChangePage != null) {
        this.onChangePage(index)
      }
    })
    .onAppear(this.onTabAppear)
    .onAttach(this.onTabAttach)
  }
}