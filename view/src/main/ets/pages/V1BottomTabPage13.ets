import { TitleBar } from '@abner/bar'
import { RouterPath } from '@abner/router'
import { HdsTabsLayout, TabBar } from '@abner/tab'
import { hdsMaterial } from '@kit.UIDesignKit'

/**
 * AUTHOR:AbnerMing
 * DATE:2026/7/3
 * INTRODUCE:底部悬浮(迷你栏)
 * */
@RouterPath("view_tabBottomTabPage13")
@Component
export struct V1BottomTabPage13 {
  tabsController: TabsController = new TabsController()
  @State tabBar: Array<TabBar> = [
    new TabBar("首页", $r("app.media.icon_home_select"), $r("app.media.icon_home_unselect")),
    new TabBar("分类", $r("app.media.icon_class_select"), $r("app.media.icon_class_unselect")),
    new TabBar("模版", $r("app.media.icon_view_select"), $r("app.media.icon_view_unselect")),
    new TabBar("我的", $r("app.media.icon_mine_select"), $r("app.media.icon_mine_unselect"))
  ]

  /**
   * AUTHOR:AbnerMing
   * INTRODUCE:tab对应的页面
   * @param index 索引
   * @param item TabBar对象，非必须
   * */
  @Builder
  itemPage(index: number, item: TabBar) {
    Text(item.title)
      .width("100%")
      .height("100%")
      .textAlign(TextAlign.Center)
      .backgroundColor($r("app.color.home_select_color"))
  }

  build() {
    Column() {
      TitleBar({ title: "V1底部悬浮(迷你栏)" })

      HdsTabsLayout({
        tabBar: this.tabBar,
        itemPage: (index: number, item: TabBar) => {
          this.itemPage(index, item)
        },
        miniBarBuilder: () => {
          this.miniBarBuilder()
        },
        onHdsTabsFloatingAttribute: (attr) => {
          attr.barWidth = { smallWidth: 200, mediumWidth: 300, largeWidth: 400 }
          attr.gradientMask = { maskColor: '#66F1F3F5', maskHeight: 92 }
          attr.systemMaterialEffect = {
            materialType: hdsMaterial.MaterialType.IMMERSIVE,
            materialLevel: hdsMaterial.MaterialLevel.ADAPTIVE
          }
        }
      }).layoutWeight(1)

    }.height("100%")

  }

  @Builder
  miniBarBuilder() {
    Row() {
      Column() {
        Image($r('app.media.startIcon'))
          .width(40)
          .height(40)
          .borderRadius(40)
      }.width(48).height(48).justifyContent(FlexAlign.Center).margin({ left: 4, right: 4 })

      Text('迷你栏')

      Column() {
        Image($r('sys.media.ohos_ic_public_pause'))
          .width(40)
          .height(40)
          .borderRadius(40)
      }.width(48).height(48).justifyContent(FlexAlign.Center)
    }
  }
}