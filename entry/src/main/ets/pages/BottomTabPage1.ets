import { BottomTabLayout, TabBar } from '@abner/tab'
import { ActionBar } from './ActionBar'

/**
 * AUTHOR:AbnerMing
 * DATE:2024/3/5
 * INTRODUCE:底部导航案例一，使用封装的BottomTabLayout，只需要page视图即可
 * */
@Entry
@Component
struct BottomTabPage1 {
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

  build() {
    Column() {
      ActionBar({ title: "底部导航案例一" })

      BottomTabLayout({
        itemPage: this.itemPage,//tab对应的页面
        tabSelectedColor: "#D81E06",//文字未选择颜色
        tabNormalColor: Color.Black,//文字未选择颜色
        tabLabelMarginTop: 10,//文字距离图片的高度
        tabScrollable: true,//是否可以滑动
        tabMarginBottom: 30, //距离底部的距离，一般可以获取底部导航栏的高度，然后进行设置
        onChangePage: (position) => {
          //页面切换
        },
        onTabBarClick: (position) => {
          //tab点击
        },
        tabBar: [
          new TabBar("首页", $r("app.media.ic_home_select"), $r("app.media.ic_home_unselect")),
          new TabBar("网络", $r("app.media.ic_net_select"), $r("app.media.ic_net_unselect")),
          new TabBar("列表", $r("app.media.ic_list_select"), $r("app.media.ic_list_unselect")),
          new TabBar("组件", $r("app.media.ic_view_select"), $r("app.media.ic_view_unselect"))
        ]
      })
    }.height("100%")
  }
}