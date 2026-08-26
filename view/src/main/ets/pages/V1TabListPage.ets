import { TitleBar } from "@abner/bar"
import { RouterPath } from "@abner/router"
import { TabLayout } from "@abner/tab"

@RouterPath("view_V1TabListPage")
@Component
export struct V1TabListPage {
  build() {
    Column() {
      TitleBar({ title: "tabs列表" })
      TabLayout({
        tabBar: ["条目一", "条目二", "条目三", "条目四", "条目五", "条目六"],
        isAvoidanceNavigation: true,//避开导航栏
        isSetMarginBottom:true,
        itemPage: (index: number, item: string) => {
          this.itemPage(index, item)
        },
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
    .height('100%')
    .width('100%')
  }

  @Builder
  itemPage(index: number, item: string) {
    ListItemPage({ type: index })
  }
}

/**
 *AUTHOR:AbnerMing
 *INTRODUCE:根据不同的类型获取不同的数据，这里仅做测试
 */
@Component
export struct ListItemPage {
  type?: number
  @State array: number[] = []

  aboutToAppear(): void {

    for (let i = 0; i < 30; i++) {
      this.array.push(i)
    }
  }

  build() {
    List() {
      ForEach(this.array, (item: number) => {
        ListItem() {
          Column() {
            Text(item.toString())
              .width("100%")
              .height(50)
              .textAlign(TextAlign.Center)
              .border({ width: 1, color: "#999999", radius: 10 })
          }.padding(10)
        }
      })
    }.width("100%")
    .height("100%")
  }
}