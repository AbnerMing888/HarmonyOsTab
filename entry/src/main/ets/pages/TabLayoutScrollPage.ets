import { BaseTabLayout, TabLayout, TabType } from '@abner/tab'
import { ActionBar } from './ActionBar'

/**
 * AUTHOR:AbnerMing
 * DATE:2024/3/5
 * INTRODUCE:可滑动导航
 * */

@Entry
@Component
struct TabLayoutScrollPage {
  @Builder
  itemPage(index: number, item: string) {
    Text(item)
      .width("100%")
      .height(50)
      .textAlign(TextAlign.Center)
      .backgroundColor(Color.Pink)
  }

  build() {
    Column() {
      ActionBar({ title: "可滑动导航" })

      Scroll() {
        Column() {

          TabLayout({
            tabBar: ["条目一", "条目二"],
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
            itemPage: this.itemPage,
            tabAttribute: (tab) => {
              tab.tabDividerStrokeWidth = 10
              tab.tabDividerLineCapStyle = LineCapStyle.Round
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
            tabBar: ["条目一", "条目二", "条目三", "条目四", "条目五", "条目六"],
            itemPage: this.itemPage,
            tabAttribute: (tab) => {
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
            tabBar: ["条目一", "条目二", "条目三", "条目四", "条目五", "条目六"],
            itemPage: this.itemPage,
            tabAttribute: (tab) => {
              tab.tabSelectedColor = Color.Red
              tab.tabDividerColor = Color.Red
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

          //跟随文字的宽度
          TabLayout({
            tabBar: ["一", "第二", "条目三", "是条目四", "我是条目五", "最后是条目六"],
            itemPage: this.itemPage,
            tabAttribute: (tab) => {
              tab.tabItemWidth = undefined
              tab.tabItemMargin = { left: 10, right: 10 }
              //更改下划线的宽度
              tab.tabDividerWidth = undefined
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

          //文字的宽度,指示器设置宽度
          TabLayout({
            tabBar: ["一", "第二", "条目三", "是条目四", "我是条目五", "最后是条目六"],
            itemPage: this.itemPage,
            tabAttribute: (tab) => {
              tab.tabItemWidth = undefined
              tab.tabItemMargin = { left: 10, right: 10 }
              //更改下划线的宽度
              tab.tabDividerWidth = 10
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

          //居中，固定下划线
          TabLayout({
            tabBar: ["条目一", "条目二"],
            itemPage: this.itemPage,
            tabType: TabType.SCROLL_CENTER,
            tabAttribute: (tab) => {
              tab.tabDividerWidth = 20
              tab.tabItemWidth = 200
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

          //自定义下划线
          BaseTabLayout({
            tabBar: ["条目一", "条目二", "条目三", "条目四", "条目五", "条目六"],
            itemPage: this.itemPage,
            tabModel: {
              tabDividerStrokeWidth: 15
            },
            itemTabIndicator: () => {
              this.tabItemTabIndicator(this) //自己定义指示器
            },
            itemTab: (index: number, item: string) => {
              this.tabItem(this, index, item)
            },
          })

          //右侧按钮
          TabLayout({
            tabBar: ["条目一", "条目二", "条目三", "条目四", "条目五", "条目六", "条目七", "条目八"],
            itemPage: this.itemPage,
            tabMenu: this.tabRightMenu, //按钮
            onChangePage: (position) => {
              //页面改变
              console.log("===页面改变:" + position)
            },
            onTabBarClick: (position) => {
              //点击改变
              console.log("===点击改变:" + position)
            }
          })
          //左侧按钮
          TabLayout({
            tabBar: ["条目一", "条目二", "条目三", "条目四", "条目五", "条目六", "条目七", "条目八"],
            itemPage: this.itemPage,
            tabLeftMenu: this.tabLeftMenu, //按钮
            tabAttribute: (tab) => {
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

          //左右按钮
          TabLayout({
            tabBar: ["条目一", "条目二", "条目三", "条目四", "条目五", "条目六", "条目七", "条目八"],
            itemPage: this.itemPage,
            tabAttribute: (tab) => {
              tab.tabDividerWidth = 20
            },
            tabLeftMenu: this.tabLeftMenu, //左侧按钮
            tabMenu: this.tabRightMenu, //右侧按钮
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
      }.padding({ bottom: 30 })
    }
  }

  @Builder
  tabItem(_this: TabLayoutScrollPage, index: number, item: string) {
    Column() {
      Text(item)
        .fontColor(Color.Black)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
    }
    .width(100)
    .height(50)
    .justifyContent(FlexAlign.Center)
  }

  @Builder
  tabItemTabIndicator(_this: TabLayoutScrollPage) {
    Image($r("app.media.icon"))
      .width(15)
      .height(15)
  }

  /**
   * AUTHOR:AbnerMing
   * INTRODUCE:右侧的按钮，可以是任何的视图
   * */
  @Builder
  tabLeftMenu() {
    Text("左侧")
      .backgroundColor(Color.Red)
      .width(50)
      .height("100%")
      .textAlign(TextAlign.Center)
  }

  /**
   * AUTHOR:AbnerMing
   * INTRODUCE:右侧的按钮，可以是任何的视图
   * */
  @Builder
  tabRightMenu() {
    Text("右侧")
      .backgroundColor(Color.Red)
      .width(50)
      .height("100%")
      .textAlign(TextAlign.Center)
  }
}
