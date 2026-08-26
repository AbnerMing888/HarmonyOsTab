import { TitleBar } from '@abner/bar'
import { RouterPath } from '@abner/router'
import { TabLayout, TabType } from '@abner/tab'

/**
 * AUTHOR:AbnerMing
 * DATE:2026/2/10
 * INTRODUCE:纵向导航
 * */

@RouterPath("view_tabTabVerticalLayoutPage")
@Component
export struct V1TabVerticalLayoutPage {
  @Builder
  itemPage(_: number, item: string) {
    Text(item)
      .width("100%")
      .height("100%")
      .fontColor(Color.White)
      .backgroundColor($r("app.color.tab_select_color"))
      .textAlign(TextAlign.Center)
  }

  build() {
    Column() {
      TitleBar({ title: "纵向导航" })

      TabLayout({
        tabBar: ["条目一", "条目二", "条目三"],
        itemPage: this.itemPage,
        isVertical: true, //纵向
        tabHeight: "100%",
        tabWidth: 100,
        tabAttribute: (tab) => {
          tab.tabDividerWidth = 20
        },
        tabType: TabType.DEFAULT, //普通的需要设置默认值，指示器不会跟着手势滑动
        onChangePage: (position) => {
          //页面改变
          console.log("===页面改变:" + position)
        },
        onTabBarClick: (position) => {
          //点击改变
          console.log("===点击改变:" + position)
        }
      }).layoutWeight(1)
    }
  }
}
