import { TabLayout } from '@abner/tab'
import { ActionBar } from './ActionBar'

/**
 * AUTHOR:AbnerMing
 * DATE:2024/3/5
 * INTRODUCE:封装普通导航 右边添加按钮
 * */
@Entry
@Component
struct TabLayoutPage6 {
  @Builder
  itemPage(index: number, item: string) {
    Text(item)
  }

  /**
   * AUTHOR:AbnerMing
   * INTRODUCE:右侧的按钮，可以是任何的视图
   * */
  @Builder
  itemMenu() {
    Text("测试")
      .backgroundColor(Color.Pink)
      .width("100%")
      .height("100%")
      .textAlign(TextAlign.Center)
  }

  build() {
    Column() {
      ActionBar({ title: "封装导航【居左滑动】" })
      TabLayout({
        tabBar: ["条目一", "条目二", "条目三", "条目四", "条目五", "条目六"],
        isTabAlignLeft: true,
        itemPage: this.itemPage,
        isShowTabMenu: true, //展示右侧的按钮
        tabMenu: this.itemMenu, //按钮
        tabMenuWidth: 100, //按钮宽度
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