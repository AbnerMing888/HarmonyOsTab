import { TabDividerAttr } from './TabDividerAttr'
import { TabTextAttr } from './TabTextAttr'
import measure from '@ohos.measure'

@Component
export struct TabBarView {
  @State private _privateTabWidth?: number = 0 //宽度
  tabWidth?: Length = 0 //高度
  tabHeight?: Length = 50 //高度
  tabList?: string[] = [] //数量
  @BuilderParam itemLayout?: (position: number) => void //tabBar布局 自定义
  isAverage?: boolean = true //是否均分
  onTabClick?: (position: number) => void //点击事件
  private _privateTabDividerAttr: TabDividerAttr = new TabDividerAttr()
  onTabDividerAttr?: (attr: TabDividerAttr) => void
  private _privateTabTextAttr: TabTextAttr = new TabTextAttr()
  onTabTextAttr?: (attr: TabTextAttr) => void
  @Prop currentIndex?: number = 0 //默认第0个
  private privateTabTextWidth?: number[] = [] //文字的宽度

  aboutToAppear(): void {
    if (this.onTabDividerAttr != undefined) {
      this.onTabDividerAttr(this._privateTabDividerAttr)
    }
    if (this.onTabTextAttr != undefined) {
      this.onTabTextAttr(this._privateTabTextAttr)
    }

    if (!this.isAverage) {
      if (this.tabWidth != 0) {
        this._privateTabWidth = Number(this.tabWidth)
      } else {
        this.tabList?.forEach((content) => {
          let textWidth = measure.measureText({
            textContent: content,
            fontSize: this._privateTabTextAttr.fontSize + "px"
          })
          this.privateTabTextWidth?.push(textWidth + 20)
        })
      }
    }


  }

  /*
  * Author:AbnerMing
  * Describe:默认的tabBar
  */
  @Builder
  defaultBarView(_this: TabBarView, item: string, position: number) {
    RelativeContainer() {
      Text(item)
        .id("t_content")
        .fontColor(this.currentIndex == position ? this._privateTabTextAttr.selectFontColor :
        this._privateTabTextAttr.fontColor)
        .fontSize(this.currentIndex == position ? this._privateTabTextAttr.selectFontSize :
        this._privateTabTextAttr.fontSize)
        .fontWeight(this.currentIndex == position ? this._privateTabTextAttr.selectFontWeight :
        this._privateTabTextAttr.fontWeight)
        .fontFamily(this.currentIndex == position ? this._privateTabTextAttr.selectFontFamily :
        this._privateTabTextAttr.fontFamily)
        .alignRules({
          middle: {
            'anchor': '__container__', 'align': HorizontalAlign.Center
          },
          center: {
            'anchor': '__container__', 'align': VerticalAlign.Center
          }
        })


      if (_this.currentIndex == position) {
        Divider()
          .strokeWidth(_this._privateTabDividerAttr.height)
          .width(_this._privateTabDividerAttr.width)
          .color(_this._privateTabDividerAttr.color)
          .lineCap(LineCapStyle.Round)
          .id("d_line")
          .alignRules({
            bottom: _this._privateTabDividerAttr.isBottom ? {
              'anchor': '__container__', 'align': VerticalAlign.Bottom
            } : {
              'anchor': 't_content', 'align': VerticalAlign.Bottom
            }
          })
          .margin({ top: _this._privateTabDividerAttr.marginTop, bottom: _this._privateTabDividerAttr.marginBottom })

      }
    }
  }

  build() {
    List({ initialIndex: 0 }) {
      ForEach(this.tabList, (item: string, position: number) => {
        ListItem() {
          Column() {
            if (this.itemLayout != undefined) {
              this.itemLayout(position)
            } else {
              this.defaultBarView(this, item, position)
            }
          }
          .width(this._privateTabWidth != 0 ? this._privateTabWidth : this.privateTabTextWidth![position])
          .height("100%")
          .justifyContent(FlexAlign.Center)
        }
        .onClick(() => {
          this.currentIndex = position
          if (this.onTabClick != undefined) {
            this.onTabClick(position)
          }
        })
      }, (item: string) => item)
    }
    .width("100%")
    .height(this.tabHeight)
    .listDirection(Axis.Horizontal)
    .scrollBar(BarState.Off)
    .onAreaChange((_: Area, newValue: Area) => {
      if (this.isAverage) {
        this._privateTabWidth = Number(newValue.width) / this.tabList?.length!
      }
    })
  }
}