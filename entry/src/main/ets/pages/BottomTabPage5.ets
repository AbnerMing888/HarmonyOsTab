import { BottomTabLayout, BottomTabType, TabBar } from '@abner/tab'
import { ActionBar } from './ActionBar'

/**
 * AUTHOR:AbnerMing
 * DATE:2024/9/8
 * INTRODUCE:底部圆角导航
 * */

@Entry
@Component
struct BottomTabPage5 {
  tabsController: TabsController = new TabsController()
  @State tabBar: Array<TabBar> = [
    new TabBar("首页", $r("app.media.ic_home_select"), $r("app.media.ic_home_unselect")),
    new TabBar("网络", $r("app.media.ic_net_select"), $r("app.media.ic_net_unselect")),
    new TabBar("列表", $r("app.media.ic_list_select"), $r("app.media.ic_list_unselect")),
    new TabBar("组件", $r("app.media.ic_view_select"), $r("app.media.ic_view_unselect"))
  ]

  /**
   * AUTHOR:AbnerMing
   * INTRODUCE:tab对应的页面
   * @param index 索引
   * @param item TabBar对象，非必须
   * */
  @Builder
  itemPage(index: number, item: TabBar) {
    Text(item.title)
      .width("100%")
      .height("100%")
      .textAlign(TextAlign.Center)
      .backgroundColor("#E8E8E8")
  }

  build() {
    Column() {
      ActionBar({ title: "底部导航案例五" })

      BottomTabLayout({
        tabsController: this.tabsController,
        itemPage: this.itemPage, //tab对应的页面
        tabSelectedColor: "#D81E06", //文字选择颜色
        tabNormalColor: Color.Black, //文字未选择颜色
        tabLabelMarginTop: 10, //文字距离图片的高度
        tabScrollable: false, //是否可以滑动
        bottomTabType: BottomTabType.ROUNDED, //底部圆角导航
        bottomTabMargin: { bottom: 40, left: "5%" },
        tabWidth: "90%",
        bottomTabBorderOptions: { radius: 30 },
        barBackgroundColor: Color.White,
        onChangePage: (position) => {
          //页面切换
          console.log("===========页面切换:" + position)
        },
        onTabBarClick: (position) => {
          //tab点击
          console.log("===========单击:" + position)
        },
        onDoubleClick: (position) => {
          //双击
          console.log("===========双击:" + position)
        },
        onTabAppear: () => {
          this.tabsController.preloadItems([1, 2])
        },
        tabBar: this.tabBar
      })
    }.height("100%")

  }
}