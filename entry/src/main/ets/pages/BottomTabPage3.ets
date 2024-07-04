import { BaseBottomTabLayout, TabBar } from '@abner/tab'
import { ActionBar } from './ActionBar'

/**
 * AUTHOR:AbnerMing
 * DATE:2024/3/5
 * INTRODUCE:底部导航案例三，和案例二一样，只不过是纯文字
 * */
@Entry
@Component
struct BottomTabPage3 {
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
      .fontColor(this.currentIndex == index ? Color.Red : Color.Black)

  }

  build() {
    Column() {
      ActionBar({ title: "底部导航案例三" })
      BaseBottomTabLayout({
        tabBar: [
          new TabBar("首页"),
          new TabBar("网络"),
          new TabBar("列表"),
          new TabBar("组件")
        ],
        itemPage: this.itemPage,
        itemTab: this.itemTab,
        tabMarginBottom: 30, //距离底部的距离，一般可以获取底部导航栏的高度，然后进行设置
        onTabBarClick: (position) => {
          //点击tab
        },
        onChangePage: (position) => {
          this.currentIndex = position
        }
      })
    }
  }
}