import { BaseTabLayout, TabLayout, TabType } from '@abner/tab'
import { ActionBar } from './ActionBar'

/**
 * AUTHOR:AbnerMing
 * DATE:2024/3/5
 * INTRODUCE:普通导航
 * */

@Entry
@Component
struct TabLayoutPage {
  @Builder
  itemPage(_: number, item: string) {
    Text(item)
      .width("100%")
      .height(60)
      .backgroundColor(Color.Pink)
      .textAlign(TextAlign.Center)
  }

  build() {
    Column() {
      ActionBar({ title: "普通导航" })

      TabLayout({
        tabBar: ["条目一", "条目二", "条目三", "条目四", "条目五", "条目六"],
        itemPage: this.itemPage,
        tabScrollable:false,
        tabType: TabType.DEFAULT, //普通的需要设置默认值，指示器不会跟着手势滑动
        onChangePage: (position) => {
          //页面改变
          console.log("===页面改变:" + position)
        },
        onTabBarClick: (position) => {
          //点击改变
          console.log("===点击改变:" + position)
        }
      })

      TabLayout({
        tabBar: ["条目一", "条目二"],
        barMode: BarMode.Fixed, //均分
        tabType: TabType.DEFAULT, //普通的需要设置默认值，指示器不会跟着手势滑动
        itemPage: this.itemPage,
        onChangePage: (position) => {
          //页面改变
          console.log("===页面改变:" + position)
        },
        onTabBarClick: (position) => {
          //点击改变
          console.log("===点击改变:" + position)
        }
      })

      TabLayout({
        tabBar: ["条目一", "条目二", "条目三", "条目四", "条目五", "条目六"],
        tabType: TabType.DEFAULT, //普通的需要设置默认值，指示器不会跟着手势滑动
        itemPage: this.itemPage,
        tabAttribute: (tab) => {
          //设置属性
          tab.tabDividerWidth = 20
        },
        onChangePage: (position) => {
          //页面改变
          console.log("===页面改变:" + position)
        },
        onTabBarClick: (position) => {
          //点击改变
          console.log("===点击改变:" + position)
        }
      })

      TabLayout({
        tabBar: ["一", "是二", "这是三", "这个是四", "这个啊是五", "这个是条目六"],
        itemPage: this.itemPage,
        tabType: TabType.DEFAULT, //普通的需要设置默认值，指示器不会跟着手势滑动
        tabAttribute: (tab) => {
          //设置属性
          tab.tabDividerMarginTop = 5 //设置下划线距离顶部
          tab.isTabDividerTextWidth = true //设置和文字宽度一致
        },
        onChangePage: (position) => {
          //页面改变
          console.log("===页面改变:" + position)
        },
        onTabBarClick: (position) => {
          //点击改变
          console.log("===点击改变:" + position)
        }
      })
    }
  }

  /**
   * AUTHOR:AbnerMing
   * INTRODUCE:右侧的按钮，可以是任何的视图
   * */
  @Builder
  itemMenu() {
    Text("测试")
      .backgroundColor(Color.Red)
      .width(100)
      .height("100%")
      .textAlign(TextAlign.Center)
  }
}
