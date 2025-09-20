import { BaseBottomTabLayout, TabBar } from '@abner/tab'
import { ActionBar } from './ActionBar'

/**
 * AUTHOR:AbnerMing
 * DATE:2024/3/5
 * INTRODUCE:底部导航案例二，使用BaseBottomTabLayout，可以自定义Tab视图
 * */
@Entry
@Component
struct BottomTabPage2 {
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
        .fontColor(this.currentIndex == index ? "#D81E06" : "#000000")
        .fontSize(14)
        .margin({ top: 5 })
    }.width("100%")
  }

  build() {
    Column() {
      ActionBar({ title: "底部导航案例二" })
      BaseBottomTabLayout({
        itemPage: this.itemPage,
        itemTab: this.itemTab,
        tabBar: [
          new TabBar("首页", $r("app.media.ic_home_select"), $r("app.media.ic_home_unselect")),
          new TabBar("网络", $r("app.media.ic_net_select"), $r("app.media.ic_net_unselect")),
          new TabBar("列表", $r("app.media.ic_list_select"), $r("app.media.ic_list_unselect")),
          new TabBar("组件", $r("app.media.ic_view_select"), $r("app.media.ic_view_unselect"))
        ],
        tabMarginBottom: 30, //距离底部的距离，一般可以获取底部导航栏的高度，然后进行设置
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
      })
    }
  }
}