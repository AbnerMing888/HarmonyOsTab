import { RouterPath } from '@abner/router'
import {BottomTabCurve} from '@abner/tab'

/**
 * AUTHOR:AbnerMing
 * DATE:2026/2/7
 * INTRODUCE:底部曲线导航
 * */
@RouterPath("view_tabBottomTabPage8")
@Component
export struct V1BottomTabPage8 {
  private tempColorArray: ResourceColor[] = ["#ffcc80", "#ff9323ac", "#ff26a965", "#ff93d923", "#ff11c5de",]
  @State selectIndex: number = 0
  private tabArray: Resource[] =
    [$r('sys.symbol.house_fill'), $r('sys.symbol.square_fill_grid_2x2'), $r('sys.symbol.bell_fill'),
      $r('sys.symbol.externaldrive_fill'), $r('sys.symbol.person_2_fill')]

  @Builder
  tabView(position: number) {
    if (this.selectIndex == position) {
      Column() {
        SymbolGlyph(this.tabArray[position])
          .fontSize(20)
          .renderingStrategy(SymbolRenderingStrategy.SINGLE)
          .fontColor([Color.Black])
      }
      .backgroundColor(Color.White)
      .width(35)
      .height(35)
      .borderRadius(35)
      .justifyContent(FlexAlign.Center)
    } else {
      SymbolGlyph(this.tabArray[position])
        .fontSize(20)
        .renderingStrategy(SymbolRenderingStrategy.SINGLE)
        .fontColor([Color.Gray])
    }

  }

  @Builder
  pageView(position: number) {
    Column() {
      Text(position.toString())
    }.width("100%")
    .height("100%")
    .justifyContent(FlexAlign.Center)
    .backgroundColor(this.tempColorArray[position])
  }

  build() {
    RelativeContainer() {
      BottomTabCurve({
        navigationSize: 5, //tab数量
        onPageChange: (position: number) => {
          this.selectIndex = position
        },
        tabView: (position: number) => {
          this.tabView(position)
        },
        pageView: (position: number) => {
          this.pageView(position)
        }
      })
    }
    .height('100%')
    .width('100%')
  }
}