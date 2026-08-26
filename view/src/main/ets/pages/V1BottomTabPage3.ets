import { TitleBar } from '@abner/bar'
import { RouterPath } from '@abner/router'
import { BaseBottomTabLayout, TabBar } from '@abner/tab'

/**
 * AUTHOR:AbnerMing
 * DATE:2024/3/5
 * INTRODUCE:底部导航案例三，和案例二一样，只不过是纯文字
 * */
@RouterPath("view_tabBottomTabPage3")
@Component
export struct V1BottomTabPage3 {
  @State currentIndex: number = 0

  /**
   * AUTHOR:AbnerMing
   * INTRODUCE:导航页面
   * */
  @Builder
  itemPage(index: number) {
    Text("页面" + index)
  }

  /**
   * AUTHOR:AbnerMing
   * INTRODUCE:导航
   * */
  @Builder
  itemTab(index: number, item: TabBar) {
    Text(item.title)
      .fontColor(this.currentIndex == index ? $r("app.color.tab_select_color") : $r("app.color.tab_normal_color"))
  }

  build() {
    Column() {
      TitleBar({ title: "底部导航案例三" })
      BaseBottomTabLayout({
        tabBar: [
          new TabBar("首页"),
          new TabBar("网络"),
          new TabBar("列表"),
          new TabBar("组件")
        ],
        itemPage: this.itemPage,
        itemTab: this.itemTab,
        barBackgroundColor: Color.White,
        navBarBackgroundColor: Color.White,
        onTabBarClick: (position) => {
          //点击tab
          console.log("==========点击了：" + position)
        },
        onChangePage: (position) => {
          this.currentIndex = position
        }
      }).layoutWeight(1)
    }.width("100%")
    .height("100%")
    .backgroundColor($r("app.color.home_select_color"))
  }
}