import { BaseBottomTabLayout, TabBar } from '@abner/tab'
import { ActionBar } from './ActionBar'

/**
 * AUTHOR:AbnerMing
 * DATE:2024/3/5
 * INTRODUCE:底部导航案例中间图片
 * */
@Entry
@Component
struct BottomTabPage4 {
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
    if (index == 2) {
      Column() {
        Image($r("app.media.add"))
          .width(50).height(50)
          .margin({ top: -10 })
      }
    } else {
      Column() {
        Column() {
          Image(this.currentIndex == index ? item.selectedIcon
            : item.normalIcon)
            .width(30).height(30)
          Text(item.title)
            .fontColor(this.currentIndex == index ? "#D81E06" : "#000000")
            .fontSize(14)
            .margin({ top: 5 })
        }
      }.width("100%")
      .justifyContent(FlexAlign.Center)
    }
  }

  build() {
    Column() {
      ActionBar({ title: "自定义底部导航(中间图片)" })
      BaseBottomTabLayout({
        itemPage: this.itemPage,
        itemTab: this.itemTab,
        barBackgroundColor: "#e8e8e8",
        centerImageMarginBottom: 10,
        tabBar: [
          new TabBar("首页", $r("app.media.ic_home_select"), $r("app.media.ic_home_unselect")),
          new TabBar("网络", $r("app.media.ic_net_select"), $r("app.media.ic_net_unselect")),
          new TabBar("中间图片"),
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