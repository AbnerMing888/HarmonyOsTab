import { TitleBar } from '@abner/bar'
import { RouterPath } from '@abner/router'
import { BottomTabLayout, BottomTabType, TabBar } from '@abner/tab'

/**
 * AUTHOR:AbnerMing
 * DATE:2024/9/8
 * INTRODUCE:底部圆角导航，以背景方式滑动
 * */
@RouterPath("view_tabBottomTabPage11")
@Component
export struct V1BottomTabPage11 {
  tabsController: TabsController = new TabsController()
  @State tabBar: Array<TabBar> = [
    new TabBar("首页", $r("app.media.icon_home_select"), $r("app.media.icon_home_unselect")),
    new TabBar("分类", $r("app.media.icon_class_select"), $r("app.media.icon_class_unselect")),
    new TabBar("模版", $r("app.media.icon_view_select"), $r("app.media.icon_view_unselect")),
    new TabBar("我的", $r("app.media.icon_mine_select"), $r("app.media.icon_mine_unselect"))
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
      TitleBar({ title: "底部导航案例(圆角形式背景)" })

      BottomTabLayout({
        tabsController: this.tabsController,
        itemPage: this.itemPage, //tab对应的页面
        tabSelectedColor: $r("app.color.tab_select_color"), //文字选择颜色
        tabNormalColor: $r("app.color.tab_normal_color"), //文字未选择颜色
        tabLabelMarginTop: 10, //文字距离图片的高度
        tabScrollable: false, //是否可以滑动
        bottomTabType: BottomTabType.ROUNDED, //底部圆角导航
        bottomTabMargin: { bottom: 40, left: "5%" },
        tabWidth: "90%",
        bottomTabBorderOptions: { radius: 30 },
        barBackgroundColor: Color.White,
        isSlidBackground: true,//需要背景
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
      }).layoutWeight(1)
    }.height("100%")

  }
}