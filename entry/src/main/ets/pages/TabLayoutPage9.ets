import { BaseTabLayout } from '@abner/tab'

/**
 * AUTHOR:AbnerMing
 * DATE:2024/3/5
 * INTRODUCE:指示器跟着滑动
 * */
@Entry
@Component
struct TabLayoutPage9 {
  @State currentIndex: number = 0 //默认选中第0个
  @State tabBarArray: Array<number> = [] //tabBar的坐标
  @State isTabTouch: boolean = true

  @Builder
  itemPage(index: number, item: string) {
    Text(item)
  }

  @Builder
  itemTab(index: number, item: string, block: (x: number) => void) {
    Column() {
      Text(item)
        .fontColor(this.currentIndex === index ? Color.Red : Color.Black)
        .fontSize(16)
        .fontWeight(this.currentIndex === index ? 500 : 400)
        .lineHeight(22)
        .margin({ top: 17, bottom: 8 })
    }.width(100)
    .onAreaChange((oldValue: Area, newValue: Area) => {
      console.log("=================")
      if (this.isTabTouch) {
        block(Number(newValue.globalPosition.x))
      }
    })
    .onTouch((event: TouchEvent) => {
      if (event.type == TouchType.Down) {
        this.isTabTouch = false
      } else if (event.type == TouchType.Up) {
        this.isTabTouch = true
      }
    })
  }

  build() {
    Column() {
      BaseTabLayout({
        tabBar: ["条目一", "条目二", "条目三", "条目四", "条目五", "条目六"],
        itemPage: this.itemPage,
        itemTab: (index: number, item: string) => {
          this.itemTab(index, item, (x: number) => {
            this.tabBarArray.push(x)
          })
        },
        tabAreaChangeArray: this.tabBarArray,
        onChangePage: (position) => {
          this.currentIndex = position
        },
        isIndicatorScroll: true
      })
    }
  }
}

