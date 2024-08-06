import { TabLayout } from '@abner/tab'
import { ActionBar } from './ActionBar'

/**
 * AUTHOR:AbnerMing
 * DATE:2024/3/5
 * INTRODUCE:封装普通导航
 * */

@Entry
@Component
struct TabLayoutPage1 {
  @Builder
  itemPage(index: number, item: string) {
    Text(item)
  }

  build() {
    Column() {
      ActionBar({ title: "封装导航【普通】" })
      TabLayout({
        tabBar: ["条目一", "条目二"],
        itemPage: this.itemPage,
        tabAttribute: (tab) => {
          //设置属性
        },
        onChangePage: (position) => {
          //页面改变
          console.log("页面改变:" + position)
        },
        onTabBarClick: (position) => {
          //点击改变
          console.log("点击改变:" + position)
        }
      })
    }
  }
}


// @Entry
// @Component
// struct TabLayoutPage1 {
//   @Builder
//   itemPage(index: number, item: string) {
//     Text(item)
//   }
//
//   build() {
//     Column() {
//       ActionBar({ title: "封装导航【普通】" })
//       TabLayout({
//         tabBar: ["条目一", "条目二"],
//         itemPage: this.itemPage,
//         tabAttribute: (tab) => {
//           //设置属性
//         },
//         onChangePage: (position) => {
//           //页面改变
//           console.log("页面改变:" + position)
//         },
//         onTabBarClick: (position) => {
//           //点击改变
//           console.log("点击改变:" + position)
//         }
//       })
//     }
//   }
// }