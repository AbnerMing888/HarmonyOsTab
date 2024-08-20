import { BaseTabLayout } from '@abner/tab'

/**
 * AUTHOR:AbnerMing
 * DATE:2024/3/5
 * INTRODUCE:自定义导航
 * */
@Entry
@Component
struct TabLayoutPage7 {
  currentIndex: number = 0 //默认选中第0个

  @Builder
  itemPage(index: number, item: string) {
    Text(item)
  }

  @Builder
  itemTab(index: number, item: string) {
    Column() {
      Text(item)
        .fontColor(this.currentIndex === index ? Color.Red : Color.Black)
        .fontSize(16)
        .fontWeight(this.currentIndex === index ? 500 : 400)
        .lineHeight(22)
        .margin({ top: 17, bottom: 8 })
      Divider()
        .strokeWidth(2)
        .color(Color.Red)
        .opacity(this.currentIndex === index ? 1 : 0)
    }.width(100)
  }

  build() {
    Column() {
      BaseTabLayout({
        tabBar: ["条目一", "条目二", "条目三", "条目四", "条目五", "条目六"],
        itemPage: this.itemPage,
        itemTab: this.itemTab,
        onTabBarClick: (position: number) => {
          console.log("====点击了：" + position)
        },
        onChangePage: (position: number) => {
          console.log("====页面切换了：" + position)
        }
      })
    }
  }
}