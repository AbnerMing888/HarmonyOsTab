import { TabLayout } from '@abner/tab'
import { ActionBar } from './ActionBar'

/**
 * AUTHOR:AbnerMing
 * DATE:2024/3/5
 * INTRODUCE:封装普通导航 居左 滑动
 * */
@Entry
@Component
struct TabLayoutPage5 {
  @Builder
  itemPage(index: number, item: string) {
    Text(item)
  }

  build() {
    Column() {
      ActionBar({ title: "封装导航【居左滑动】" })
      TabLayout({
        tabBar: ["条目一", "条目二", "条目三", "条目四", "条目五", "条目六"],
        isTabAlignLeft: true,
        itemPage: this.itemPage,
        tabAttribute: (tab) => {
          //设置属性

        },
        onChangePage: (position) => {
          //页面改变
          console.log("页面改变:" + position)
        }
      })
    }
  }
}