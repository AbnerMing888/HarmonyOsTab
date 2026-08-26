import { TitleBar } from '@abner/bar';
import { MainView, startPage } from '@abner/router';

@Entry
@Component
struct Index {
  private items: string[] = [
    "封装底部导航", "底部导航信息标记", "自定义底部导航", "自定义底部导航纯文字",
    "底部导航(中间图片)", "底部导航(中间图片+边框线)", "底部导航(中间图片+曲线)",
    "底部圆角导航", "底部圆角导航(背景)", "底部曲线导航", "底部模糊导航",
    "可滑动导航", "普通导航", "系统滑动导航", "纵向tab", "底部悬浮", "底部悬浮(迷你栏)",
    "tabs列表"
  ]
  private routers: string[] = [
    "tabBottomTabPage1",
    "tabBottomTabPage9",
    "tabBottomTabPage2",
    "tabBottomTabPage3",
    "tabBottomTabPage4",
    "tabBottomTabPage6",
    "tabBottomTabPage7",
    "tabBottomTabPage5",
    "tabBottomTabPage11",
    "tabBottomTabPage8",
    "tabBottomTabPage10",
    "tabTabLayoutScrollPage",
    "tabTabLayoutPage",
    "tabTabSystemLayoutPage",
    "tabTabVerticalLayoutPage",
    "tabBottomTabPage12",
    "tabBottomTabPage13",
    "V1TabListPage"
  ]

  build() {
    RelativeContainer() {
      MainView() {
        Column() {
          TitleBar({ title: "v1tab组件库", hideLeftMenu: true })

          Grid() {
            ForEach(this.items, (item: string, index: number) => {
              GridItem() {
                Text(item)
                  .fontColor($r("app.color.tab_select_color"))
                  .textStyle()
                  .textAlign(TextAlign.Center)
                  .onClick(() => {
                    //点击
                    startPage("view_" + this.routers[index])
                  })
              }
            }, (item: string) => JSON.stringify(item))
          }.columnsTemplate("1fr 1fr")
          .rowsGap(10)
          .columnsGap(10)
          .padding({ left: 10, right: 10 })
        }
        .width('100%')
        .height("100%")
        .justifyContent(FlexAlign.Start)
      }
    }

  }

  @Styles
  textStyle() {
    .height(50)
    .width("100%")
    .border({ width: 1, color: $r("app.color.tab_select_color"), radius: 10 })
  }
}
