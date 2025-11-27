import { BaseBottomTabLayout } from './BaseBottomTabLayout'
import { BottomTabType } from './BottomTabType'
import { TabBar } from './TabBar'
import { TabBarController } from './TabBarController'

/**
 * AUTHOR:AbnerMing
 * DATE:2024/2/20
 * INTRODUCE:自定义底部TabLayout
 * */

@Component
export struct BottomTabLayout {
  @BuilderParam itemPage: (index: number, item: TabBar) => void //tab对应得页面
  tabSelectedColor: ResourceColor = Color.Black //tab选中颜色
  tabNormalColor: ResourceColor = Color.Gray //tab未选中颜色
  tabSelectedBgColor: ResourceColor = Color.Transparent //选中背景颜色
  tabNormalBgColor: ResourceColor = Color.Transparent //未选中背景颜色
  tabIconWidth: number = 20 //图片icon的宽度
  tabIconHeight: number = 20 //图片icon的高度
  tabSize: number = 14 //tab文字大小
  tabWeight: number | FontWeight | string = 0 //文字权重
  tabLabelMarginTop: number = 5 //标签距离图片的高度
  @Prop tabBar: Array<TabBar> = []
  tabWidth: Length = '100%' //tab指示器的宽度
  @Prop tabHeight: number = 56 //tab指示器的高度
  @Prop currentIndex: number = 0 //默认是第一个
  onChangePage?: (position: number) => void //页面切换监听
  onTabBarClick?: (position: number) => void //tab点击监听
  tabScrollable: boolean = false //默认不可以滑动
  tabMarginBottom: number = 0 //tab距离底部的距离
  onDoubleClick?: (index: number) => void //双击
  @Prop isTabClickIntercept?: boolean = false //tab点击拦截
  barBackgroundColor: ResourceColor = Color.Transparent //tabBar的背景颜色
  navBarBackgroundColor: ResourceColor = Color.Transparent //底部导航栏背景颜色
  @State _tabBarTitle: string[] = [] //用于动态改变
  @Prop tabPositionInterceptArray: Array<number> = [] //拦截索引
  tabBarController?: TabBarController
  tabsController: TabsController = new TabsController()
  onTabAppear?: () => void
  onTabAttach?: () => void
  bottomTabType?: BottomTabType = BottomTabType.DEFAULT
  bottomTabBorderOptions?: BorderOptions
  bottomTabMargin?: Margin | Length | LocalizedMargin
  barBorder?: BorderOptions //设置tabBar底部边框样式
  barBackgroundEffect?: BackgroundEffectOptions

  aboutToAppear(): void {
    if (this.tabBarController != undefined) {
      this.tabBar.forEach((item) => {
        this._tabBarTitle.push(item.title!)
      })
      this.tabBarController.onChangeTitle = (position: number, title: string) => {
        this._tabBarTitle[position] = title
      }
    }
  }

  @Builder
  itemTab(_this: BottomTabLayout, index: number, item: TabBar) {
    Column() {

      Image(_this.currentIndex == index ? item.selectedIcon : item.normalIcon)
        .width(_this.tabIconWidth)
        .height(_this.tabIconHeight)

      Text(_this.tabBarController != undefined ? _this._tabBarTitle[index] : item.title)
        .fontColor(_this.currentIndex == index ? _this.tabSelectedColor : _this.tabNormalColor)
        .fontSize(_this.tabSize)
        .fontWeight(_this.tabWeight)
        .margin({ top: _this.tabLabelMarginTop })
    }.width("100%")
    .height("100%")
    .justifyContent(FlexAlign.Center)
    .backgroundColor(_this.currentIndex == index ? _this.tabSelectedBgColor : _this.tabNormalBgColor)
  }

  build() {
    Column() {
      BaseBottomTabLayout({
        itemPage: this.itemPage,
        tabBar: this.tabBar,
        bottomTabType: this.bottomTabType,
        barBackgroundColor: this.barBackgroundColor,
        navBarBackgroundColor: this.navBarBackgroundColor,
        tabPositionInterceptArray: this.tabPositionInterceptArray,
        itemTab: (index: number, item: TabBar) => {
          this.itemTab(this, index, item)
        },
        tabsController: this.tabsController,
        tabWidth: this.tabWidth,
        tabHeight: this.tabHeight,
        tabIconWidth: this.tabIconWidth,
        tabIconHeight: this.tabIconHeight,
        onChangePage: (position: number) => {
          this.currentIndex = position
          if (this.onChangePage != undefined) {
            this.onChangePage(position)
          }
        },
        tabSelectedColor: this.tabSelectedColor,
        tabNormalColor: this.tabNormalColor,
        tabSelectedBgColor: this.tabSelectedBgColor,
        tabNormalBgColor: this.tabNormalBgColor,
        tabScrollable: this.tabScrollable,
        currentIndex: this.currentIndex,
        tabMarginBottom: this.tabMarginBottom,
        bottomTabBorderOptions: this.bottomTabBorderOptions,
        bottomTabMargin: this.bottomTabMargin,
        onTabBarClick: this.onTabBarClick,
        onDoubleClick: this.onDoubleClick,
        isTabClickIntercept: this.isTabClickIntercept,
        onTabAppear: this.onTabAppear,
        onTabAttach: this.onTabAttach,
        barBorder: this.barBorder,
        barBackgroundEffect: this.barBackgroundEffect
      })
    }
  }
}