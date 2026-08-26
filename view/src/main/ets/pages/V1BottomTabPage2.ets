import { TitleBar } from '@abner/bar'
import { RouterPath } from '@abner/router'
import { BaseBottomTabLayout, TabBar } from '@abner/tab'

/**
 * AUTHOR:AbnerMing
 * DATE:2024/3/5
 * INTRODUCE:底部导航案例二，使用BaseBottomTabLayout，可以自定义Tab视图
 * */
@RouterPath("view_tabBottomTabPage2")
@Component
export struct V1BottomTabPage2 {
  private currentIndex = 0 //默认是第一个

  /**
   * AUTHOR:AbnerMing
   * INTRODUCE:tab对应的页面
   * @param index 索引
   * @param item TabBar对象，非必须
   * */
  @Builder
  itemPage(index: number, item: TabBar) {
    Text(item.title)
  }

  /**
   * AUTHOR:AbnerMing
   * INTRODUCE:自定义Tab视图，自己绘制
   * @param index 索引
   * @param item TabBar对象，非必须
   * */
  @Builder
  itemTab(index: number, item: TabBar) {
    Column() {
      Image(this.currentIndex == index ? item.selectedIcon
        : item.normalIcon)
        .width(30).height(30)
      Text(item.title)
        .fontColor(this.currentIndex == index ? $r("app.color.tab_select_color") : $r("app.color.tab_normal_color"))
        .fontSize(14)
        .margin({ top: 5 })
    }.width("100%")
  }

  build() {
    Column() {
      TitleBar({ title: "底部导航案例二" })
      BaseBottomTabLayout({
        itemPage: this.itemPage,
        itemTab: this.itemTab,
        barBackgroundColor: Color.White,
        navBarBackgroundColor: Color.White,
        tabBar: [
          new TabBar("首页", $r("app.media.icon_home_select"), $r("app.media.icon_home_unselect")),
          new TabBar("分类", $r("app.media.icon_class_select"), $r("app.media.icon_class_unselect")),
          new TabBar("模版", $r("app.media.icon_view_select"), $r("app.media.icon_view_unselect")),
          new TabBar("我的", $r("app.media.icon_mine_select"), $r("app.media.icon_mine_unselect"))
        ],
        onTabBarClick: (position) => {
          //tab点击
          console.log("====点击了Tab" + position)
        },
        onChangePage: (position) => {
          //页面切换
          console.log("====页面切换了" + position)
        },
        onDoubleClick: (position) => {
          //双击
          console.log("===========双击:" + position)
        },
      }).layoutWeight(1)
    }.width("100%")
    .height("100%")
    .backgroundColor($r("app.color.home_select_color"))
  }
}