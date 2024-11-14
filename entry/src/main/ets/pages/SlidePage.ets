import { SlideTab } from '@abner/tab'

@Entry
@Component
struct SlidePage {
  @Builder
  itemPage(index: number, item: Object) {
    Text(item.toString())
      .width("100%")
      .height("100%")
      .backgroundColor(Color.Pink)
      .textAlign(TextAlign.Center)
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
      SlideTab({
        tabBar: ["条目一", "条目二", "条目三", "条目四", "条目五", "条目六", "条目七"],
        itemPage: this.itemPage,
        barMode: BarMode.Scrollable,
        tabMenu: this.itemMenu,
        isShowTabMenu:true,
        tabMenuWidth:80,
        onChangePage: (position) => {
          console.log("==============切换：" + position)
        },
        onTabBarClick: (position) => {
          console.log("==============点击：" + position)
        }
      })
    }
  }
}