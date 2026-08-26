import { TitleBar } from '@abner/bar'
import { RouterPath } from '@abner/router'
import { HdsTabsLayout, TabBar } from '@abner/tab'
import { hdsMaterial } from '@kit.UIDesignKit'

/**
 * AUTHOR:AbnerMing
 * DATE:2026/7/2
 * INTRODUCE:底部悬浮
 * */
@RouterPath("view_tabBottomTabPage12")
@Component
export struct V1BottomTabPage12 {
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
    Scroll() {
      Image($r("app.media.taobao_index"))
    }.padding({ bottom: 80 })
  }

  build() {
    Column() {
      TitleBar({ title: "V1底部导航悬浮" })

      HdsTabsLayout({
        tabBar: this.tabBar,
        itemPage: (index: number, item: TabBar) => {
          this.itemPage(index, item)
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
}