import { TabLayout } from '@abner/tab'
import { ActionBar } from './ActionBar'

/**
 * AUTHOR:AbnerMing
 * DATE:2024/3/5
 * INTRODUCE:封装普通导航 居左
 * */
@Entry
@Component
struct TabLayoutPage4 {
  @Builder
  itemPage(index: number, item: string) {
    Text(item)
      .height("100%")
      .width("100%")
      .textAlign(TextAlign.Center)
      .backgroundColor(Color.Pink)
  }

  build() {
    Column() {
      ActionBar({ title: "封装导航【居左】" })
      TabLayout({
        tabBar: ["条目一", "条目二"],
        isTabAlignLeft: true,
        itemPage: this.itemPage,
        tabAttribute: (tab) => {
          //设置属性
        },
        onTabBarClick: (position) => {
          console.log("==点击改变:" + position)
        },
        onChangePage: (position) => {
          //页面改变
          console.log("==页面改变:" + position)
        }
      })
    }
  }
}